-- Enquanto do notation nos fornece uma alternativa para
-- sequenciação, idoms nos fornece uma alternativa para 
-- aplicação. A notação e seus exemplos nessa sessão
-- são inspiradas por "Applicative Programming with Effects"
-- de Conor McBride e Ross Paterson.

-- Primeiro, vamos revisitar m_add abaixo. Tudo que isso
-- faz é aplicar um operador para dois valores extraidos
-- de Maybe Int. Nós podemos abstrair isso fora da aplicação

m_app : Maybe (a -> b) -> Maybe a -> Maybe b
m_app (Just f) (Just a) = Just (f a)
m_app _        _        = Nothing

-- Usando isso, nós podemos escrever uma alternativa para
-- m_add que usa essa notação alternativa com chamadas
-- explicitas de m_app.

m_add : Maybe Int -> Maybe Int -> Maybe Int
m_add x y = m_app (m_app (Just (+)) x) y

-- Além de ter que aplicar m_app em todos os lugares
-- aqui temos uma aplicação, nós podemos utilizar idiom brackets
-- para fazer esse trabalho pos nós. Para fazer isso podemos
-- fornecer para Maybe uma implementação de Applicative
-- como a seguir, onde <*> é definido da mesma forma que
-- m_app abaixo (isso já é definido na biblioteca de Idris):

-- Applicative Maybe where
--   pure = Just

--   (Just f) <*> (Just a) = Just (f a)
--   _        <*> _        = Nothing

-- Usando <*> nós podemos utilizar a seguinte aplicação,
-- onde uma aplicação de uma função [| f a1 ...an|] é
-- traduzido para pure f <*> a1 <*> ... <*> an:

m_add' : Maybe Int -> Maybe Int -> Maybe Int
m_add' x y = [| x + y |]