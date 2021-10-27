-- Um exemplo padrão de tipos de dados dependentes é o tipo de "Listas com length"
-- Convencionalmente chamados de vetores na literatura de tipos dependentes.
-- Eles estão disponiveis como parte da biblioteca padrão do Idres.
-- Basta importar Data.Vect, ou podemos declarar um como seguinte:

data Vect : Nat -> Type -> Type where
    Nil : Vect Z a
    (::) : a -> Vect k a -> Vect (S k) a


-- Note que utilizamos os mesmos contrutores que utilizamos para Listas.
-- A sobrecarga de nomes para esse proposito é aceito por Idris, desde que os nomes sejam declarados
-- em diferentes namespaces (por exemplo, em um modulo diferente).
-- Ambiguidade de nome de construtores pode normalmente ser resolvida com contexto.

-- Isso declara uma familia de tipos, então a forma de declaração é diferente da
-- simples declaração acima. Declaramos explicitamente o tipo do construtor de tipo Vect.
-- Isso recebe um Nat e um tipo Type. Nos falamos que Vect é indexado por Nat e parametrizado por Type.
-- Cada construtor foca em uma diferente parte da familia de tipos.
-- Nil pode ser usado apenas para construir vetores de tamanho Z.
-- :: é utilizado para construir vetores com o tamanho diferente de zero.
-- No  tipo ::, nos declaramos explicitamente um elemento do tipo a e uma "causa" do tipo Vect k a (um vetor de tamanho x)
-- combinado para fazer um vetor de tamanho S k.

-- Podemos definir funções em tipos dependentes como Vect da mesma forma
-- que utilizamos em tipos simples como Lista e Nat acima, com pattern matching.
-- O tipo da função Vect vai descrever o que acontece com o tamanho
-- dos vetores envolvidos. Por exemplo, ++, definido a seguir, acrescenta dois vetores.

(++) : Vect n a -> Vect m a -> Vect (n + m) a
(++) Nil       ys = ys
(++) (x :: xs) ys = y :: xs ++ ys

-- O tipo de (++) declara que o resultado do tamanho do vetor vai ser a soma
-- do tamanho dos inputs. Se utilizarmos a definição de forma errada
-- onde ela não seja valida, idris não vai aceita ela. Por exemplo:

(++) : Vect n a -> Vect m a -> Vect (n + m) a
(++) Nil       ys = ys
(++) (x :: xs) ys = x :: xs ++ xs -- BROKEN

-- Quando rodarmos através do idris type checker, 
-- vai resultar no seguinte:

-- idris VBroken.idr --check
-- VBroken.idr:9:23-25:
-- When checking right hand side of Vect.++ with expected type
--         Vect (S k + m) a

-- When checking an application of constructor Vect.:::
--         Type mismatch between
--                 Vect (k + k) a (Type of xs ++ xs)
--         and
--                 Vect (plus k m) a (Expected type)

--         Specifically:
--                 Type mismatch between
--                         plus k k
--                 and
--                         plus k m

-- Esse erro sugere que existe uma erro de tamanho entre os dois vetores
-- Precisamos de um vetor de tamanho k + m, mas informamos um vetor de tamanho k + k.

