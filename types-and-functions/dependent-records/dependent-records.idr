import Data.Vect

record Person where
  constructor MkPerson
  firstName, middleName, lastName : String
  age : Int

-- Registros também podem depender de valores. Registros
-- possuem parametros, o que não pode ser atuyalizados
-- que nem outros campos. Os parametros aparecem como
-- argumentos do tipo resultado, e são escritos seguindo
-- do nome do registro. Por exemplo, um par de tipos pode
-- ser definidos da seguinte forma:

record Prod a b where
  constructor Times
  fst : a
  snd : b

-- Usando o registro Class visto mais cedo, o tamanho de class
-- pode ser restrito usando Vect e o tamanho fornecido como
-- parametro do registro. Por exemplo:

record SizedClass (size: Nat) where
  constructor SizedClassInfo
  students : Vect size Person

-- No caso de addStudent visto mais cedo, nós ainda podemos
-- adicionar em SizedClass dado que o tamanho é implicito
-- e vai ser atualizado quando um novo aluno é adicionado:

addStudent : Person -> SizedClass n -> SizedClass (S n)
addStudent p c = record { students = p :: students c } c

-- Em fato, o tipo de pares dependentes que nós já vimos,
-- em patrica, definido como um record, com os campos 
-- fst e snd nos permite projetar valores fora do par

record DPair1 a (p : a -> Type) where
  constructor MkDPair1
  fst : a
  snd : p fst
  
-- É possivel utilizar a sintaxe de atualização de registros
-- para atualizar campos dependentes, provendo todos os
-- campos necessários para atuaializar de uma vez. Por exemplo:

cons : t -> (x ** Vect x t) -> (x ** Vect x t)
cons val xs
  = record { fst = S (fst xs),
             snd = (val :: snd xs) } xs

-- Ou até mesmo:

cons' : t -> (x ** Vect x t) -> (x ** Vect x t)
cons' val
    = record { fst $= S,
               snd $= (val ::) }