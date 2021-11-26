-- As vezes nós queremos encontrar um padrão imediatamente
-- após o resultado de uma função em uma do-notation
-- Por exemplo, vamos dizer que temos uma função readNumber
-- que lê um número do consolem, retorna um valor do 
-- formulario Just x se o numero for valido, se não Nothin:

import Data.String

readNumber : IO (Maybe Nat)
readNumber = do
  input <- getLine
  if all isDigit (unpack input)
    then pure (Just (stringToNatOrZ input))
    else pure Nothing

-- Se nós utilizarmos isso então para criar uma função
-- que lê dois numero, retornarnado Nothing se alguma não
-- estiver ok, então nós vamos querer utilizar pattern
-- matching no resultado de readNumber:

readNumbers : IO (Maybe (Nat, Nat))
readNumbers =
  do x <- readNumber
     case x of
          Nothing => pure Nothing
          Just x_ok => do y <- readNumber
                          case y of
                               Nothing => pure Nothing
                               Just y_ok => pure (Just (x_ok, y_ok))

-- Se tivermos muitos errors handlers, isso pode acabar
-- muito confuso facilmente, então, nós podemos combinar
-- o bind e o pattern matching um por linha. Por exemplo
-- nós podemos tentar utilizar pattern matching na forma
-- Just x_ok:

-- readNumbers' : IO (Maybe (Nat, Nat))
-- readNumbers' =
--   do Just x_ok <- readNumber
--      Just y_ok <- readNumber
--      pure (Just (x_ok, y_ok))

-- Mas ainda continua com um problema, pois nós apagamos
-- o caso de Nothing, então readNumber não é uma função
-- total. Nós podemos adicionar o case Nothing da forma
-- aplicada a seguir:

readNumbers' : IO (Maybe (Nat, Nat))
readNumbers' =
  do Just x_ok <- readNumber
          | Nothing => pure Nothing
     Just y_ok <- readNumber
          | Nothing => pure Nothing
     pure (Just (x_ok, y_ok))


-- O efeito nessa versão de readNumbers é idenfico ao do
-- primeiro (em geral, é um açucar sintativo para isso)
-- A primeira parte de cada caso (Just x_ok <- e 
-- Just y_ok <- e) fornece o binding ok. Se isso for igual
-- a execução vai continuar com o restante do do block.
-- A segunda parte informa um caso diferente, que podem ser
-- mais de um.

