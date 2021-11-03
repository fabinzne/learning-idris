-- Argumentos Implicitos

-- Vamos dar uma olhada no tipo de index:

index : Fin n -> Vec n a -> a
 
-- Ele recebe dois argumentos, um elemento de Conjuntos Finitos
-- e um vetor com n elementos do tipo a. Porém também possui dois nomes.
-- n e a, que não são declarados explicitamente. Esses são os
-- argumentos implicitos de index. Nos também podemos escrever o tipo
-- de index como:

index : {a: Type} -> {n: Nat} -> Fin n -> Vect n a -> a

-- Argumentos implicitos, usados com chaves {} em sua declaração,
-- não são dados na aplicação de index. Seus valores podem ser
-- inferidos a partir dos tipos dos argumentos de Fin n e Vect n a.
-- Qualquer nome começando com letra minuscula que é utilizado
-- na declaração de tipos, que não é aplicavel a nenhum argumento
-- sempre vai ser considerado um argumento implicito.
-- Argumentos implicitos podem ainda ser usados explicitamente
-- em aplicações, usando {a=value} e {n=value}, por exemplo:

index {a=Int} {n=2} FZ (2 :: 3 :: Nil)

-- De fato, qualquer argumento, implicito ou explicito deve
-- ter um nome. Podemos declarar o tipo de index como:

index : (i: Fin n) -> (xs: Vect n  a) -> a

-- Isso é uma questão de gosto e pode ser utilizado sempre que você
-- quiser. -- as vezes isso pode ajudar a documentar uma função
-- fazendo o proposito dos argumentos mais claros.

-- Além disso, {} podem ser usados em pattern matching no lado
-- esquerdo, i.e. {var = pat} pega uma variavel implicita e
-- tenta fazer o pattern matching com "pat". Por exemplo:

isEmpty : Vect n a -> Bool
isEmpty {n = Z} _ = True
isEmpty {n = S k} _ = False