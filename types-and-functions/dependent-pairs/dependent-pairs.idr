import Data.Vect

-- Pares dependentes permitem que o tipo de um segundo
-- elemento de um pair dependa de um valor do primeiro
-- elemento:

data DPair : (a : Type) -> (p : a -> Type) -> Type where
  MkDPair : {p : a -> Type} -> (x : a) -> p x -> DPair a p

-- Novamente, existe uma sintaxe facilitadora para isso.
-- (x: a ** p) que é o tipo de um pair de A e P, onde o nome
-- x pode ocorrer dentro de p. (x ** p) constroi o valor
-- do tipo de a. Por exemplo, podemos parear um numero com
-- um Vect de um tamanho particular.

vec : (n : Nat ** Vect n Int)
vec = (2 ** [3, 4])

-- Se você preferir, você pode escrever isso sem utilizar
-- a versão mais longa; os dois são equivalentes:

vec1 : Main.DPair Nat (\n => Vect n Int)
vec1 = MkDPair 2 [3, 4]

-- O type checker pode inferir o valor do primeiro elemento
-- do tamanho de um vetor. Podemos escrever um _ (underline)
-- no lugar dos valores que esperamos que o type checker
-- irá preencher isso, então a ultima definição pode
-- ser escrita como:

vec2 : (n : Nat ** Vect n Int)
vec2 = (_ ** [3, 4])

-- Nós provavelmente preferimos omitir o tipo do primeiro
-- elemento do par, dado que, novamente, ele pode ser 
-- inferido:

vec3 : (n ** Vect n Int)
vec3 = (_ ** [3, 4])

-- Um uso para pares dependentes é retornar um valor de um
-- tipo dependente onde o index não é necessáriamente conhecido
-- em tempo. Por exemplo, se vamos filtrar elementos do
-- Vect de acordo com um Predicato, nós não vamos
-- saber qual o tamanho do vetor passado vai ser:

filter : (a -> Bool) -> Vect n a -> (p ** Vect p a)

-- Se o Vetor está vazio, o resultado vai ser:

filter p Nil = (_ ** [])

-- No caso ::, nós precisamos inspecionar o resultado de uma
-- chamada recursava para filter para extrair o tamanho e o
-- vetor do resultado. Para fazer isso, nós usamos uma
-- expressão case, que permite dar match nos valores
-- intermediarios:

filter p (x :: xs)
    = case Main.filter p xs of
        (_ ** xs') => if p x then (_ ** x :: xs')
                             else (_ ** xs')

-- Pares dependentes as vezes são referidos como "Sigma Types"
