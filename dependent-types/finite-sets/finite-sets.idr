-- Sets finitos, como o nome sugere, são sets com um numero finito de elementos.
-- Eles estão disponiveis como parte da biblioteca padrão do idris
-- importando Data.Fin, ou podem ser declados como a seguir:

data Fin : Nat -> Type where
    FZ : Fin (S k)
    FS : Fin k -> Fin (S k)

-- Pela assinatura, podemos ver que é um constutor de tipo
-- que recebe um Nat e produz um type. Então isso não é um set
-- no senso de uma coleção, isso é um container de objetos
-- ao contrario, é um canonico set de elementos sem nome,
-- como em "o set de 5 elementos", por exemplo. 
-- Efetivamente é um tipo que captura inteiros que caem no range
-- de zero para (n - 1) onde n é o argumento usado para instanciar
-- o tipo Fin. Por exemplo, Fin 5 pode ser considerado o tipo
-- de inteiro entre 0 e 4.

-- Vamois dar uma olhada no construtor com bastante detalhes

-- FZ é o elemento zero de um set finito com elementos S k;
-- FS n é o n + 1 de um set finito com elementos S k.
-- Fin é indexado por um Natural, que representa o numero
-- de elementos no set. Considerando que não podemos
-- contruir um elemento de um set vazio, nem um construtor focar em Fin Z.

-- Como mencinado acima, uma boa aplicação da familia Fin é para
-- representar numeros naturais limitados. Desde que os primeiros
-- n numeros naturais formam um conjunto finito de n elementos.
-- Podemos tratar Fin n como um set de inteiros maior ou igual
-- a zero e menor que n.

-- Por exemplo, a seguinte função que procura por um elemento
-- em um Vect, por um index limitado passado por Fin n, é definido a seguir:

index : Fin n -> Vect n a -> a
index FZ     (x :: xs) = x
index (FS k) (x :: xs) = index k xs

-- Essa função busca por um valor em uma localização dada no vetor.
-- A localização é limitada pelo tamanho do vetor (n em cada caso),
-- então não existe a necessidade de um check do limite em run-time.
-- O type checker garante que a localização não é maior que o tamanho
-- do vetor, e também claro, não é menor que zero.

-- Note também que não temos caso para Nil aqui. Isso é porque
-- isso é impossivel, pois não existe elemento Fin Z, e a localização
-- é um Fin n, então N não pode ser Z. Como resultado, tentando localizar
-- um elemento em um vetor vazio dara um erro de tipos em compilação
-- desde que isso forçaria n a ser Z.