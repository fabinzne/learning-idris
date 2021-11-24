-- Valores podem ser pareados com o seguinte tipo:

data Pair a b = MkPair a b

-- Como uma facilitação, podemos escrever (a, b) que, de 
-- acordo com a contexto, significa tanto Pair a b quanto
-- MkPair a b. Tuplas podem conter um numero arbitrario
-- de valores, representados como pares misturados.

fred : (String, Int)
fred = ("Fred", 42)

jim : (String, Int, String)
jim = ("Jim", 25, "Cambridge")

-- *UsefulTypes> fst jim
-- "Jim" : String
-- *UsefulTypes> snd jim
-- (25, "Cambridge") : (Int, String)
-- *UsefulTypes> jim == ("Jim", (25, "Cambridge"))
-- True : Bool