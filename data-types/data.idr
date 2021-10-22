-- Sintaxe menos verbosa mas menos flexivel:

data Nat    = Z   | S Nat           -- Numeros naturais

data List a = Nil | (::) a (List a) -- Lista polirformica

-- Sintaxe mais verbosa mas menos flexivel:

data Nat : Type where 
    Z : Nat
    S : Nat -> Nat

data List : Type -> Type where 
    Nil : List a
    (::) : a -> List a -> List a


-- Declaramos listas utilizando o Operador ::

-- Novos operadores que nem esse podem ser adicionados usando uma declaração fixity, como a seguinte:

infixr 10 ::

-- Funções, construtores de dados e construtores de tipos podem ter infix proprios como nome.
-- Eles podem ser utilizados em forma de prefixo se englobados por parenteses. Ex: (::)
-- Alguns operadores feitos por esses simbolos não podem ser definidos pelo usuarios: [:+-*\/=.?|&><!@$%^~#]
