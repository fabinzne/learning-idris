-- Funções são declaradas com Pattern Matching, semelhantes a sintaxe de Haskell
-- A principal diferença é que Idris requer declarações de tipos para todas as funções, usando apenas : (diferente do usado por Haskell [::])

-- Algumas operações com numero naturais:

-- Adição unaria
plus : Nat -> Nat -> Nat
plus Z     y = y
plus (S k) y = S (Main.plus k y)

-- Multiplicação unaria
mult : Nat -> Nat -> Nat
mult Z      y = Z
mult (S k) y = Main.plus y (Main.mult k y)


-- WHERE

-- Funções também podem ser definidar localmente usando WHERE. Por exemplo:
-- Para definir uma função que reverte uma lista, nós podemos usar uma função auxiliar
-- qual acumula a nova, lista inversa, e não precisa de ser visivel globalmente

reverse : List a -> List a
reverse xs = revAcc [] xs where 
    revAcc : List a -> List a -> List a
    revAcc acc [] = acc
    revAcc acc (x :: xs) = revAcc (x :: acc) xs

-- Como em funções, blocos declarados com where podem incluir declarações de dados locais
-- por exemplo o seguinte MyLT que não pode ser acessado fora da definição de foo

foo : Int -> Int
foo x = case isLT of
        Yes => x*2
        No => x*4
    where 
        data MyLT = Yes | No

        isLT : MyLT
        isLT = if x < 20 then Yes else No

-- Em geral funções definidas dentro de um bloco where precisam de
-- declarações de tipo que nem qualquer outra Função. Porém, a declaração de tipos
-- para uma função f pode ser omitida se

-- f aparece no lado direito na definição de uma função Top Level
-- O tipo de f pode ser completamente determinado em sua primeira aplicação

-- Por exemplo as seguintes definições são permitidas:

even : Nat -> Bool
even Z = True
even (S k) = odd k where 
    odd Z = False
    odd (S k) = even k

test : List Nat
test = [c (S 1), c Z, d (S Z)]
    where c x = 42 + x
          d y = c (y + 1 + z y)
                where z w = y + w