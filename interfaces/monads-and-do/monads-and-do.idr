-- A interface Monad nos permite encapsular abstrações e é
-- a base de do-notation introduzida em "do" notation.
-- Isso extende Applicative que foi definido anteriormente.
-- e é definido da seguinte forma:

interface Applicative m => Main.Monad (m: Type -> Type) where
    (>>=) : m a -> (a -> m b) -> m b

-- Também existe uma versão não facilitada para se definir
-- Monad como a seguir:

-- v >> e = v >>= \_ => e

-- Dentro de um bloco "do", a seguinte sintaxe para
-- transformação é aplicada>

-- x <- v; e se torna v >>= (\x => e)
-- v; e se torna v >> e
-- let x = v; e se torna let x = v in e

-- IO possui uma implementação de Monad, definida utilizando
-- funções primitivas. Nós também podemos definir Maybe 
-- como a seguir:

Main.Monad Maybe where
    Nothing  >>= k = Nothing
    (Just x) >>= k = k x

-- Usando isso, nós podemos, por exemplo, definir uma função
-- que adiciona dois Maybe Int usando a monad para encapsular
-- tratamentos de errors:

m_add : Maybe Int -> Maybe Int -> Maybe Int
m_add x y = do x' <- x -- Extrai o valor de X
               y' <- y -- Extrai o valor de Y
               pure (x' + y') -- Adiciona eles

-- Essa função vai extrair os valores de x e y, se os dois
-- estiverem disponiveis, ou retornarem Nothing, caso os
-- dois não sejam "errors". Gerenciar o caso Nothing
-- é conquista pelo operador >>=, escondido pelo do-notation.

-- Main> m_add (Just 82) (Just 22)
-- Just 94
-- Main> m_add (Just 82) Nothing
-- Nothing

-- A tradução de do notation é inteiramente sintatica,
-- então não necessitamos dos operaodres (>==) ou (>>) para
-- serem as definições da interface Monad. Idris vai, no geral
-- tentar remover a ambiguidade dos operadores que você 
-- deseja utilizando tipos, mas você pode explicitamente
-- escoolher uma do notation qualificada, por exemplo:

m_add1 : (Main.Monad m, Num a) => m a -> m a -> m a
m_add1 x y = Predule.do
    x' <- x
    y' <- y
    pure (x' + y')

-- O Prelude.do indica que Idris vai utilizar os operadores
-- (>>=) e (>>) definidos no Predule.