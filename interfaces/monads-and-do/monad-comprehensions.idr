-- A notação de list comprehension que vimos nas sessões
-- anteriores é mais geral, e pode ser aplicado a qualquer
-- coisa que é a implementação de Monad e Alternative:

interface Applicative f => Main.Alternative (0 f : Type -> Type) where
  empty : f a
  (<|>) : f a -> f a -> f a

-- Em geral, comprehension recebem a forma
-- [ exp | qual1, qual2, ..., qualn ]
-- onde quali pode ser um de:

-- Um gerador x <- e
-- Um guard, que é uma expressão do tipo Bool
-- Um binding de let let x = e

-- Para trduzir uma comprehension [exp | qual1, qual2, ..., qualn]
-- primeiro qualquer qualificador qual que é um guard é
-- traduzido para guard qual, usando a seguinte função

guard : Main.Alternative f => Bool -> f ()

-- Então a comprehension é convertida para uma do-notation:

-- do { qual1; qual2; ...; qualn; pure exp; }

-- Usando monads comprehension, uma alternativa
-- para a definicação de m_add seria:

m_add : Maybe Int -> Maybe Int -> Maybe Int
m_add x y = [ x' + y' | x' <- x, y' <- y ]
