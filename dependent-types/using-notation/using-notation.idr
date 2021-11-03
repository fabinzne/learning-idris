-- "using" notation

-- As vez é util prover tipos para argumentos implicitos, particularment
-- onde existir uma ordenação de dependencias, ou o argumento implicito
-- possui uma dependencia. Por exemplo, podemos desejar declarar os tipos
-- de argumentos implicitos da seguinte forma, que define um
-- predicato em vetores (isso é também definido em Data.Vect,
-- chamado de Elem):

data isElem : a -> Vect n a -> Type where
Here : {x: a} -> {xs: Vect n a} -> isElem x (x :: xs)
There : {x,y: a} -> {xs: Vect n a} -> isElem x xs -> isElem x (y :: xs) 

-- Uma instacia de isElem x xs declara que x é um elemento de xs.
-- Podemos contruir um predicato se o elemento necessario for Here,
-- no cabeçalho de um vector, ou There, na calda de um vetor.
-- Por exemplo:

textVec : Vect 4 Int
textVec = 3 :: 4 :: 5 :: 6 :: Nil

inVect : isElem 5 Main.textVec
inVect = There (There Here)

-- ! --- IMPORTANTE --- !

-- Argumentos implicitos e escopo:

-- Dentro da assinatura de tipos, o typechecker vai tratar
-- todos as variaveis que começam com letra minuscula e não
-- são aplicadas a outra coisa como um argumento implicito.
-- Para conseguir compilar o código acima, você vai ter que
-- prover um nome qualificado para |testVec|. No exemplo acima
-- nós assumimos que o código vive com o modulo Main.

-- ! ------------------ !

-- Se o mesmo argumento implicito é utilizado muitas vezes,
-- pode tornar a definição mais dificil de ler. Para evitar
-- esse problema, um bloco |using| fornece o tipo e a ordem que
-- qualquer argumento pode aparecer dentro do bloco:

using (x: a, y: a, xs: Vect n a)
    data isElem : a -> Vect n a -> Type where
        Here : isElem x xs -> isElem x (y :: xs)

-- NOTA: Pedido de declaração e bloqueios mutuos.

-- Em geral, funções e tipos de dados, devem ser definidos antes
-- de serem usados, desde que tipos dependentes permitam funções
-- aparecerem como parte de tipos, e o type checking pode contar
-- em como funções particulares são definidas (Embora isso seja,
-- apenas para funções totais). De qualquer forma, essa restrição
-- pode ser flexibilizada com o uso de blocos mutuos, que permitem
-- tipos de dados e funções serem definidas simultaneamente:

mutual
    even : Nat -> Bool
    even Z = True
    even (S k) = odd k

    odd : Nat -> Bool
    odd Z = False
    odd (S k) = even k

-- Em um bloco mutuo, primeito todas as declarações de tipos são adicionadas
-- depois o corpo das funções. Como resultado, nenhum dos tipos das funções
-- podem depender da redução de qualquer outra função no bloco.
