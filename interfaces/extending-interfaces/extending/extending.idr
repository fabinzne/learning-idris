-- Interfaces também podem ser extendidas. O próximo passo
-- da relação de igualdade em Eq é definir a relação de 
-- ordenção Ord. Nós podemos definir a interface Ord que 
-- extende métodos de Eq mesmo que algumas sejam declaradas
-- por eles mesmos:

data Ordering = LT | EQ | GT

interface Eq a => Main.Ord a where
    compare : a -> a -> Main.Ordering

    (<)  : a -> a -> Bool
    (>)  : a -> a -> Bool
    (<=) : a -> a -> Bool
    (>=) : a -> a -> Bool
    max  : a -> a -> a
    min  : a -> a -> a

-- A interface Ord permite a comparação de dois valores
-- e determinar sua ordem. Apenas o método compare é obrigatório
-- Qualquer outro método possui uma definição padrão. Usando
-- isso, nós podemos escrever funções como sort, uma função
-- que organiza a lista em ordem crescente, fornecido pelo
-- tipo da lista na interface Ord. Nós informamos as restrições
-- de tipos do lado esquerdo da seta maior =>
-- e o tipo da função na direita:

sort : Main.Ord a => List a -> List a 


-- Funções, intergaves e implementações podem conter varias
-- restrições. Multiplas restrições são escritar em parênteses:
-- com uma lista separada por virgula, por exemplo:

sortAndShow : (Main.Ord a, Show a) => List a -> String
sortAndShow xs = show (sort xs)

-- Restrições são, como tipos, objetos de primeira classe
-- na linguagem. Você pode ver isso com o REPL:

-- Main> :t Ord
-- Prelude.Ord : Type -> Type

-- Então, (Ord a, Show a) é um par ornirario de tipos, com
-- duas restrições como o primeiro e o segundo valor do par