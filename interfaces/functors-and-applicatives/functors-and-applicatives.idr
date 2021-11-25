-- Anteriormente vimos interfaces com apenas um parametro
-- onde o parametro é do tipo Type. Em geral, podem haver
-- qualquer numero de parametros (até zero), e os parametros
-- podem ter qualquer tipo. Se o tipo do parametro não é Type
-- nós precisamos informar uma declaração explicita do tipo
-- Por exemplo, a interface Functor é definida no Predule
-- da seguinte forma:

interface Main.Functor (0 f : Type -> Type) where
  map : (m : a -> b) -> f a -> f b

-- Um fuctor permite a função ser aplicada através de uma
-- estrutura, por exemplo, aplicar a função para cara elemento
-- de uma Lista:

Main.Functor List where
  map f []        = []
  map f (x :: xs) = f x :: Main.map f xs

-- Idris> map (*2) [1..10]
-- [2, 4, 6, 8, 10, 12, 14, 16, 18, 20] : List Integer


-- Tendo definido Functor, nós podemos definir Applicative
-- que abstrai a notação de um aplicação de funções:

infixl 2 <*>

interface Main.Functor f => Main.Applicative (0 f : Type -> Type) where
  pure  : a -> f a
  (<*>) : f (a -> b) -> f a -> f b
