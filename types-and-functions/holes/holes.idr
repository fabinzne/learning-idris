-- Programar em idris podem ter buracos que significa partes incompletas do programa.
-- Por exemplo, podemos deixar uma buraco para greeting no nosso programa: "Hello, world!:

module Main

main : IO ()
main = putStrLn ?greeting


-- A sintaxe ?greeting introduz um buraco, que espera por uma parte do programa que ainda não foi escrita.
-- Esse é um programa valido em idris, e você pode verificar o tipo de greeting

-- 
-- *Hello> :t greeting
-- --------------------------------------
-- greeting : String
--

-- Vertificando o tipo de um buraco tabém mostra o tipo de qualquer variavel no escopo.
-- Por exemplo, definindo even de forma incompleta

even : Nat -> Bool
even Z = True
even (S k) = ?even_rhs

-- Podemos checar o tipo de even_rhs e ver o tipo esperado para o retorno e o tipo da variavel k:

--
-- *Even> :t even_rhs
--  k : Nat
-- --------------------------------------
-- even_rhs : Bool

