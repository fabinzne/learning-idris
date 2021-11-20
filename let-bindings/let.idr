import Data.Vect

-- Valores intermediarios podem ser calculados utilizando
-- let:

mirror: List a -> List a
mirror xs = let xs' = reverse xs in
                xs ++ xs'

-- Nós podemos utilizar patern matching em let's também.
-- Por exemplo, nós podemos extrair um campo de um registro
-- como a seguir, utilizando pattern matching no top-level:

data Person = MkPerson String Int

showPerson : Person -> String
showPerson p = let MkPerson name age = p in
                name ++ " is " ++ show age ++ " years old"

-- Esses let's podem ser anotados com um tipo
mirror' : List a -> List a
mirror' xs = let xs' : List a = reverse xs in
                xs ++ xs'


-- Nós também podemos utilizar o sinal := no lugar de =
-- para, com todas as outras coisas, evitar ambiguidade
-- com igualdade proposicional:

Diag : a -> Type
Diag v = let ty : Type := v = v in ty

-- Definições locais também podem serem introduzidas usando
-- let. Da mesma forma que definições top-level e as 
-- definições dentro de um bloco where você precisa:

-- 1 -> Declarar a função e seu tipo
-- 2 -> Definir a função por pattern matching

foldMap : Monoid m => (a -> m) -> Vect n a -> m
foldMap f = let fo : m -> a -> m 
                fo ac el = ac <+> f el
              in foldl fo neutral

-- O simbolo := não pode ser utilizado em funções definidas
-- localmente. O que seguinifica que pode ser utilizado
-- para intercalar let's e funções definidas localmente
-- sem indroduzir ambiguidade.

foldMap' : Monoid m => (a -> m) -> Vect n a -> m
foldMap' f = let fo : m -> a -> m
                 fo ac el = ac <+> f el
                 initital := neutral
                 --       ^ Isso indica que 'initial' é uma definição 
                 -- não relevante para a denifição de 'fo'
              in foldl fo initital