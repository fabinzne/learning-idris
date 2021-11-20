-- Idris provê uma notação de compreenção, o que é conveniente
-- para gerar listas de forma simples. A forma geral é:

-- [ expressão | eliminadores ]

-- Isso gera uma lista de valores produzidos pela validação
-- da `expressão` de acordo com a condição data pelos `eliminadores`.
-- Por exemplo, podemos contribuir listas de Triangulos
-- Pitagóricos, como a seguir:

pythag : Int -> List (Int, Int, Int)
pythag n = [ (x, y, z) | z <- [1..n], y <- [1..z], x <- [1..y],
                         x*x + y*y == z*z ]

-- A notação [a..b] é uma outra forma curta de se criar listas
-- de numeros entre a e b. Alternatizamente [a,b..c] gera uma
-- lista de numeros entre a e c, com o incremento especificado
-- na diferença entre a e b. Isso funciona para tipos Nat
-- Int e Integer, usando as funções enumFromTo e enumFromThenTo
-- do modulo Prelude
