import Data.Vect
-- Idris inclui um grande numero de tipos de dados e bibliotecas
-- de funções (veja o diretório libs/ na distribuição e na documentação).
-- Essa sessão descreve uma parte desses e como importar eles.

-- List e Vect

-- Nós já vimos os tipos de dados List e Vect:

-- data List a = Nil | (::) a (Main.List a)

-- data Vect : Nat -> Type -> Type where
--   Nil  : Vect Z a
--   (::) : Vect k a -> Vect (S k) a

-- Voce pode obter acesso a Vect com o import `Main.Vect`.
-- Note que o nome do construtor é o mesmo para cada um.
-- Nomes de construtores (no geral, nomes) podem ser sobrecarregados
-- desde que sejam declarados em diferentes namespaces.
-- (Veja na sessão de Modules and Namespaces), e tipicamente
-- vão ser resolvidos de acordo com seus tipos. Como açucar
-- sintatico, qualquer implementação dos nomes Nil e ::
-- podem ser escritos em forma de Lista. Por Exemplo

-- [] quer dizer Nil
-- [1,2,3] quer dizer 1 :: 2 :: 3 :: Nil

-- SImiliar, qualquer implementação dos nomes Lin e :<
-- podem ser escritos de forma soc-list:

-- [<] quer dizer Lin
-- [< 1, 2, 3] quer dizer 1 :< 2 :< 3.

-- E o Predule inclui uma implementação pré-definida de snoc-lists:

data SnocList a = Lin | (?<) (Main.SnocList a) a

-- A biblioteca também define um grande numero de funções
-- para manipular esses tipos. Map é sobrecarregado para
-- List e Vect e aplica a função para cada elemento da lista
-- ou vetor.

-- map : (a -> b) -> Prelude.List a -> Prelude.List b
-- map f []        = []
-- map f (x :: xs) = f x :: map f xs

map : (a -> b) -> Vect n a -> Vect n b
map f []        = []
map f (x :: xs) = f x :: map f xs

-- Por exemplo, dando o seguinte vetor de inteiros e uma
-- função para dobrar um inteiro:

intVec : Vect 5 Int 
intVec = [1, 2, 3, 4, 5]

double : Int -> Int
double x = x * 2

-- A função map pode ser usada da seguinte forma para dobrar
-- cada elemento do vetor:

-- show (map double intVec)
-- "[2, 4, 6, 8, 10]" : String

-- Para mais detalhes de cada função disponivel em List
-- e Vect, veja nos arquivos das bibliotecas.