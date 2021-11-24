-- Maybe, definido no module Prelude, descreve um valor 
-- opcional. Ou tem um valor do tipo informado ou não tem.

data Maybe a = Just a | Nothing

-- Maybe é um jeito de representar um tipo para uma operação
-- que pode falhar. Por exemplo, buscando algo em uma Lista
-- (em vez de um vetor) pode resultar em um error por 
-- estar fora do escopo.

list_lookup : Nat -> List a -> Main.Maybe a
list_lookup _       Nil = Nothing
list_lookup Z (x :: xs) = Just x
list_lookup (S k) (x :: xs) = list_lookup k xs

-- A função maybe é usada para processar valores do tipo
-- Maybe, apenas aplicando a função ao valor, se tiver um
-- ou fornecendo um valor paradão.

maybe : Lazy b -> Lazy (a -> b) -> Main.Maybe a -> b

-- Nore que o tipo dos primeiros dois argumentos estão
-- cobertos por um Lazy, pois apenas um dos dois argumentos
-- serão realmente utilizados, nós marcamos eles como lazy
-- em um caso onde é uma grande expressão e seria eficiente
-- computar o valor e depois descartar eles.
