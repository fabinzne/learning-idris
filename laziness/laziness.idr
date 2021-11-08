-- Normalmente, argumentos de funções são âvaliados antes
-- da propria função (isso, idris usa um a avaliação rapida)
-- De qualquer forma, isso nem sempre é a melhor solução.
-- Considere a seguinte função:

ifThenElse : Bool -> a -> a -> a
ifThenElse True  t e = t 
ifThenElse False t e = e

-- Essa função usa um dos argumentos t ou e, mas não ambos.
-- Nós iriamos preferir se apenas o argumento utilizado
-- fosse avaliado. Para conseguir isso, Idris provê o tipo
-- primitivo Lazy, que nos permite suspender a avaliação.
-- Apesar de ser um tipo primitivo, nós podemos abstrair
-- da seguinte forma

data Lazy : Type -> Type where
  Delay : (val : a) -> Lazy a

Force : Lazy a -> a

-- Um valor do tipo Lazy não é avaliado até que seja forçado
-- com Force. O type checker de idris conhece o tipo Lazy
-- e insere as conversões onde necessario entre Lazy a e a,
-- e virce versa. Nós podemos agora escrever a função
-- ifThenElse da seguinte formo, sem nenhum uso explicito
-- de Force ou Delay:

ifThenElse : Bool -> Lazy a -> Lazy a -> a
ifThenElse True t e = t
ifThenElse False t e = e
