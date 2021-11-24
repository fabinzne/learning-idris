-- A biblioteca prelude define uma interface Eq que fornece
-- metodos para comparar valores em igualdade ou não, o que
-- é implementado para todos os tipos padrões:

interface Eq a where
    (==) : a -> a -> Bool
    (/=) : a -> a -> Bool

-- Para declara a implementação de um tipo, nós precisamos
-- fornecer denifinições para todos os métodos. Por exemplo,
-- uma implementação de Eq para Nat:

Eq Nat where
    Z     == Z     = True
    (S x) == (S y) = x == y
    Z     == (S y) = False
    (S x) == Z     = False  

    x /= y = not (x == y)

-- É dificil de imaginar varios casos onde o método /= vai 
-- ser algo diferente da negação de ==. De qualquer forma
-- é conveniente fornecer um valor padrão para a definição
-- de cada método na declaração da interface, em termos como
-- o outro méotod:

interface Eq a where
    (==) : a -> a -> Bool
    (/=) : a -> a -> Bool

    x /= y = not (x == y)
    x == y = not (x /= y)

-- Uma implementação minima de Eq para ser completo necessita
-- que tanto == ou /= sejam definidos, mas não reqer ambos
-- Se uma definição de um método estiver faltando, e houver
-- uma definição padrão para o mesmo, então o padrão será
-- utilizado