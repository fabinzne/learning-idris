-- Dipos de dados infinitos (codata) permite a gente definir
-- estruturas de dados infinitas utilizando argumentos recursivos
-- como pontenciais infinitos. Um exemplo de um tipo infinito
-- é Stream, que é definido da seguinte forma:

data Stream : Type -> Type where
  (::) : (e : a) -> Inf (Main.Stream a) -> Main.Stream a

-- O seguinte é um exemplo de como codata type Stream pode ser
-- utilizado para formar uma estrutura de dados infinita.
-- Nesse caso nós vamos criar uma Stream infinita de uns.

ones : Main.Stream Nat
ones = 1 :: ones