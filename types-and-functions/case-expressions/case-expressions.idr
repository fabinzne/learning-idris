import Prelude.Types

list_lookup : Nat -> List a -> Maybe a
list_lookup _       Nil = Nothing
list_lookup Z (x :: xs) = Just x
list_lookup (S k) (x :: xs) = list_lookup k xs

-- Uma outra forma de inspecionar valore intermediarios é
-- utilizando a expressão `case`. A função a seguir, por exemplo
-- divide uma string em duas em um caracter separador.

-- splitAt : Char -> String -> (String, String)
-- splitAt c x = case break (== c) x of
--                 (x, y) => (x, strTail y)

-- Break é uma função de uma biblioteca que quebra a string
-- em pares de strings onde o ponto informado retorna true
-- Quando ela desconstroi o par isso retorna e remove
-- o primeiro caracter da segunda string.

-- Uma expressão `case` pode encontrar diversos casos,
-- por exemplo, para inspecionar valores intermediarios
-- do tipo Maybe a. Retorne a funlção list_lookup que 
-- busca o index de uma lista, retornando Nothing se o
-- index está além do escopo. Nós podemos usa isso para
-- escrever lookup_default, o que olha para o index e retorna
-- um valor padrão se index estiver além do escopo:

lookup_default : Nat -> List a -> a -> a
lookup_default i xs def = case list_lookup i xs of
                              Nothing => def
                              Just x => x

-- Se o index estiver dentro excopo, nós podemos obter
-- o valor daquele index, caso contrario recebemos um valor
-- padrão:

-- *UsefulTypes> lookup_default 2 [3,4,5,6] (-1)
-- 5 : Integer
-- *UsefulTypes> lookup_default 4 [3,4,5,6] (-1)
-- -1 : Integer