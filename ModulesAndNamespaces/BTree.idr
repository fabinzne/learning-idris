-- Um programa em idris consiste em uma coleção de modulos
-- Cada modulo inclui uma declaração opcional module, 
-- informando o nome do modulo, uma lista de imposts, informando
-- outros modulos que necessitam ser importados
-- e uma coleção de declarações e definições de tipos,
-- interfaces e funções. Por exemplo, a lista abaixo
-- informa o modulo que define uma Arvore Binaria,
-- o tipo BTree, em um arquivo BTree.idr

module BTree

public export
data BTree a = Leaf
             | Node (BTree a) a (BTree a)

export
insert : Ord a => a -> BTree a -> BTree a
insert x Leaf         = Node Leaf x Leaf
insert x (Node l v r) = if (x < v) 
                          then (Node (insert x l) v r)
                          else (Node l v (insert x r))

export
toList : BTree a -> List a
toList Leaf         = []
toList (Node l v r) = BTree.toList l ++ (v :: BTree.toList r)

export
toTree : Ord a => List a -> BTree a
toTree []        = Leaf
toTree (x :: xs) = insert x (toTree xs)

-- Os modificares export e public export dizem quais nomes
-- estão visiveis em outro namespace. Esses que serão explicados
-- logo abaixo;

-- Então, isso informa ao programa principal, em um
-- arquivo bmain.idr que usa o modulo BTree para
-- organizar uma lista
