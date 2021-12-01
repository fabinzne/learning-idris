import Data.Vect
-- Idris 2 é baseado na Teoria de Tipos Quantitativos (QTT), uma
-- linguagem desenvolvida por Bob Atkey e Conor McBride. Na pratica
-- isso significa que cada variavel em idris2 tem uma quantidade
-- associada a isso. Uma quantidade é:

-- 0, significando que aquela variavel é apagada em run-time

-- 1, significando que aquela variavel é utilizada exatamente uma
-- vez em run-time

-- Unrestricted, que é o mesmo que em idris 1


-- Nós podemos ver multiplicidades de variaveis inspecionando
-- buracos. Por exemplo, se nós temos o seguinte esqueleto
-- defenido para append em vetores:

append : Vect n a -> Vect m a -> Vect (n + m) a
append xs ys =  ?append_rhs

-- Nós podemos olhar para o buraco em append_rhs:

-- Main> :t append_rhs
--  0 m : Nat
--  0 a : Type
--  0 n : Nat
--    ys : Vect m a
--    xs : Vect n a
-- -------------------------------------
-- append_rhs : Vect (plus n m) a

-- O 0 próximo de m, a e n significa que elas estão no escopo
-- mas terão 0 ocorrencias em run-time. Isso é, isso garante que
-- elas vão ser apagadas em run-time.

-- Multiplicidades podem ser explicitamente escritar em tipos
-- de funções, como a seguir:

ignoreN: (0 n : Nat) -> Vect n a -> Nat -- Essa função não pode
-- olhar para n em run-time.

duplicate : (1 x : a) -> (a, a) -- Essa função deve utilizar x
-- apenas uma vez. (Não possui implementação pois x necessita
-- ser utilizado 2x)

-- Se não exeritir a anotação de multiplicidade, o argumento é
-- unrestricted. Se, em outra mão, o nome é implicito (como a em
-- todos os exemplos acima) o argumento é apagado. Então os tipos
-- podem ser exscritos como:

ignoreN' : {0 a : _} -> (0 n : Nat) -> Vect n a -> Nat

duplicate' : {0 a : _} -> (1 x : a) -> (a, a)

-- Essa sessão descreve o que isso significa para seus programas
-- em idris2 na pratica, com diversos exemplos. Em particular,
-- é descrito:

-- Erasure - Como saber o que é relevante em run-time ou não.

-- Linerialidade - Utilizar o type system para encodar protocolos
-- de usagem de resources.

-- Pattern Matching em Tupos - verdadeiros first class types.

