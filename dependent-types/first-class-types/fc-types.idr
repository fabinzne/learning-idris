-- Em idris, tipos são de primeira classe
-- Isso significa que podem ser computados e manipulados (por exemplo, passando para funções)
-- assim como qualquer outra linguagem.
-- Por exemplo, podemos escrever uma função que computa um tipo:

isSingleton : Bool -> Type
isSingleton True = Nat
isSingleton False = List Nat

-- Essa função calcula o tipo apropriado a partir de um Booleano
-- Qual especificase o tipo deve ser um singleton ou não.
-- Podemos utar essa função para calcular um tipo em qualquer lugar que o tipo possa ser usado
-- Por exemplo, podemos usar para calcular o tipo de um retorno de uma função:

mkSingle : (x: Bool) -> isSingleton x
mkSingle True = 0
mkSingle False = []

-- Ou pode ser usada para a função ter tipos de input diferente.
-- A função seguinte calcula tanto a soma de uma lista de naturais
-- ou retorna o natural fornecido, dependendo se isSingleton é verdadeiro

sum : (single: Bool) -> isSingleton single -> Nat
sum True x = x
sum False [] = 0
sum False (x :: xs) = x + sum False xs

main : IO ()
main = do printLn $ sum True 1
          printLn $ sum False [1,2,3]
          printLn $ sum False [1]
          printLn $ sum False []