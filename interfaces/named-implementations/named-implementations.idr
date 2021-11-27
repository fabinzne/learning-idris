-- Pode ser desejavel haver multiplas implementações de uma
-- interface para o mesmo tipo, por exemplo, para prover 
-- métodos alternativos para organizar ou printar valores.
-- Para conseguir isso, implementações podem ser nomeadas
-- como a seguir:

[myOrd] Ord Nat where
  compare Z     (S n) = GT
  compare (S n) Z     = LT
  compare Z     Z     = EQ
  compare (S x) (S y) = compare @{myOrd} x y


-- Isso declara uma implementação como normalmentem, mas
-- com o nome myOrd explicito. A sintaxe compare @{myOrd}
-- fornece uma implementação explicita para compare,
-- se não, utilizariamos a implementação padrão para Nat.
-- Nós podemos utilizar isso para organizar uma lista
-- de Nat ao contrario. Dada a seguinte list:

testList : List Nat
testList = [3,4,1]

-- Podemos organizar utilizando a implementação padrão
-- para Ord, utilizando a função sort disponiviel com o
-- import Data.List, e também podemos tentar a 
-- implementação myOrd como a seguir:

-- Main> show (sort testList)
-- "[1, 3, 4]"
-- Main> show (sort @{myord} testList)
-- "[4, 3, 1]"

-- As vezes nós também precisamos do acesso de um o nome
-- de uma implementação pai. Por exemplo, prelude define
-- a seguinte Semigroup interface:

interface Main.Semigroup ty where
  (<+>) : ty -> ty -> ty

-- Então isso define Monoid, que extende Semigroup com
-- um valore "neutro":

interface Main.Semigroup ty => Main.Monoid ty where
  neutral : ty

-- Nós podemos definir duas implementaçõe de Semigroup e
-- Monoid para Nat, um baseado em adição e outro em
-- multiplicação:

[PlusNatSemi] Main.Semigroup Nat where
  (<+>) x y  = x + y

[MultNatSemi] Main.Semigroup Nat where
  (<+>) x y = x * y

-- O valor neutro para adição é 0, mas o valor neuro para
-- multiplicação é 1. Isso é importante, pois quando definirmos
-- a implementação de Monoids, ele deve extender o Semigroup
-- correto. Podemos fazer isso com using clause na implementaão
-- como a seguir:

[PlusNatMonoid] Main.Monoid Nat using PlusNatSemi where
  neutral = 0

[MultNatMonoid] Main.Monoid Nat using MultNatSemi where
  neutral = 1

-- A clausula using PlusNatSemi indica que PlusNatMonoid
-- deve extender PlusNatSemi especificadamente.