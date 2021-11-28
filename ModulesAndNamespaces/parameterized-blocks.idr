import Data.Vect
-- Grupos de funções podem ser parametrizados em cima de um numero
-- de argumentos, usando a declaração parameters, por exemplo:

parameters (x : Nat, y : Nat)
    addAll : Nat -> Nat
    addAll z = x + y + z

-- O efeito de parameters block é de adicionar os parametros 
-- declarados para todas funções, tipos e construtores de dados
-- dentro do bloco. Expecificadamente adicionando os parametros
-- na frente da lista de argumentos. Fora do bloco, os parametros
-- devem ser fornecidos explicitamente. A função addAll, quando
-- chamada pelo REPL, vai ter a seguinte assinatura de tipos

-- addAll : Nat -> Nat -> Nat -> Nat

-- e a seguinte definição?

addAll' : (x : Nat) -> (y : Nat) -> (z : Nat) -> Nat
addAll' x y z = x + y + z

-- Blocos parametrizados podem ser misturados, e também podem
-- uncluir declarações de dadosm en que cada caso de parametro são
-- adicionados explicitamente para TODOS os tipos e construtores
-- de dados. Eles talvez sejam tipos dependente o que implicita
-- argumento?

parameters (y : Nat, xs : Vect x a)
    data Vects : Type -> Type where
        MkVects : Vect y a -> Vects a

    append : Vects a -> Vect (x + y) a
    append (MkVects ys) = xs ++ ys

-- Para utilizar Vects ou append fora do bloco, nós também
-- precisaremos informar os argumentos xs e y. Aqui, nós podemos
-- usar placeholders para os valores que podem ser inferidos pelo
-- type checker

-- Main> show (append _ _ (MkVects _ [1,2,3] [4,5,6]))
-- "[1, 2, 3, 4, 5, 6]"