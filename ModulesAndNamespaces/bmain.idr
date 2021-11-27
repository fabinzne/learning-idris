module Main

import BTree

main : IO ()
main = do let t = toTree [1,8,2,7,9,3]
          print (BTree.toList t)

-- Os mesmos nomes podem ser definidos em modulos diferentes
-- Nomes são qualificados com o nome do modulo. Os nomes
-- completos definidos em BTree module são:

-- BTree.BTree
-- BTree.Leaf
-- BTree.Node
-- BTree.insert
-- BTree.toList
-- BTree.toTree

-- Se nomes não forem ambiguos, não é necessário informar
-- o nome completo. Nomes podem ser desambifiquados tanto
-- informando um qualificador explicito, utilizando a chave
-- with, ou de acordo com seu tipo

-- A chave with em uma expressão vem em duas variantes

with BTree.insert (insert x empty) -- Para um nome
with[BTree.inser, BTree.empty] (insert x empty) -- Para multiplos nomes

-- Isso é particularmente util com a do notation, onde
-- isso pode melhorar as mensagens de error.

-- Não existe uma linkagem formal do nome do module com o
-- nome do arquivo, mas de qualquer forma é recomendado
-- utilizar o mesmo nome para cada. Um import se refere
-- ao nome do arquivo, e utiliza pontos (.) para separar
-- os diretorios. Por exemplo, import foo.bar deve importar
-- o arquivo foo/bar.idr, que deve convencionalmente ter
-- sua declaração de modulo `module foo.bar`. o unico 
-- requisito para nomes de modulos é que o main module,
-- com a função main, deve ser chamado Main
-- Mas o arquivo não necessita ser Main.idr