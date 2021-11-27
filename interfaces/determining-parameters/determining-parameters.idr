-- Quando uma interface tem mais de um parametro, pode ajudar
-- se os parametros usados para encontrar a implmenetação sejam
-- restritor. Por exemplo:

interface Monad m => MonadState s (0 m : Type -> Type) | m where
  get : m s
  put : s -> m ()


-- Nessa interface, apenas m necessita de ser conhecido para
-- encontrar a implmentação da interface, e s pode ser
-- deperminado pela implementação. Isso é declarado
-- com o | m após a declaração da interface, porque isso é
-- o parametro utilizado para encontrar a implmentação. Isso
-- é similiar ao conveito de functional dependencies em Haskell
-- (http://www.haskell.org/haskellwiki/Functional_dependencies)