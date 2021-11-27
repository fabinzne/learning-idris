-- Idiom notation é comumente usada quando precisamos
-- definir avaliações. McBride e Paterson descreve isso
-- como uma avaliador[1], para uma linguaguim similiar
-- a seguinte:

data Expr = Var String    -- Variavel
          | Val Int       -- Valor
          | Add Expr Expr -- Adição

-- A avaliação ocorrerá em uma relação com as variaveis de
-- mapeamento do contexto (representadas como String) para
-- os valores Inteiros e possivelmente pode falhar.
-- Definimos um tipo de dados Eval para envolver um avaliador:

data Eval : Type -> Type where
  MkEval : (List (String, Int) -> Maybe a) -> Eval a

-- Envolvendo o avaliador em um tipo de dados, significa
-- que poderemos prover uma implementação de interfaces
-- para isso no futuro. Nós começamos por definir uma
-- função para revuperar os valores do contexto durante
-- a avaliação:

fetch : String -> Eval Int
fetch x = MkEval (\e => fetchVal e) where
  fetchVal : List (String, Int) -> Maybe Int
  fetchVal [] = Nothing
  fetchVal ((v, val) :: xs) = if (x == v)
                                then (Just val)
                                else (fetchVal xs)


-- Quando definimos um avaliador para a linguagem, nós vamos
-- aplicar funções dentro do contexto de Eval, então é natural
-- fornecer para Eval uma implmenetação de Applicative. Antes
-- Eval poder ter uma implementação em Applicative, é necessario
-- Eval ter uma implementação de Functor:

Functor Eval where
  map f (MkEval g) = MkEval (\e => map f (g e))

Applicative Eval where
  pure x = MkEval (\e => Just x)

  (<*>) (MkEval f) (MkEval g) = MkEval (\x => app (f x) (g x)) where
    app : Maybe (a -> b) -> Maybe a -> Maybe b
    app (Just fx) (Just gx) = Just (fx gx)
    app _         _         = Nothing  

-- Avaliar uma expressão pode utilizar a aplicação idiomatica
-- para lidar com errors:

eval : Expr -> Eval Int
eval (Var x) = fetch x
eval (Val x) = [| x |]
eval (Add x y) = [| eval x + eval y |]

runEval : List (String, Int) -> Expr -> Maybe Int
runEval env e = case eval e of
  MkEval envFn => envFn env

-- Por exemplo:

-- InterpE> runEval [("x", 10), ("y",84)] (Add (Var "x") (Var "y"))
-- Just 94
-- InterpE> runEval [("x", 10), ("y",84)] (Add (Var "x") (Var "z"))
-- Nothing
