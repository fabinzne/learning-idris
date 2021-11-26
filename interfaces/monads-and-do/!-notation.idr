-- Em vários casos, usar do-notation pode fazer o programa
-- ficar muito verboso desnecessariamente, particularmente
-- em casos como m_add abaixo onde o limite do valor é usado
-- apenas uma vez, imediatamente. Nesses casos, nós
-- podemos utilizar uma versão menor, como é o seguinte:

m_add : Maybe Int -> Maybe Int -> Maybe Int
m_add x y = pure (!x + !y)

-- A notação !expr significa que a expressão expr deve
-- ser avaliada e implicitamente retornada. Conceitualmente
-- nós podemos pensar que ! é um prefixo de uma função
-- do seguite tipo:

-- (!) : m a -> a

-- Note que isso na verdade não é uma função, é apenas uma
-- sintaxe! Na pratica a subexpressão !expr vai elevar
-- expr o mais alto possivel em seu escopo atual,
-- alterar para o novo nome x e trocar !expr por x.
-- Expressões são elevadas em profundidada primeiro,
-- da esquerda para direitam. Na pratica, !-notation
-- permite a gente de programar em um estilo mais direto, enquanto
-- continua fornecendo uma notação proxima das expressões
-- monadicas

-- Por exemplo, a expressão:

let y = 94 in f !(g !(print y) !x)

-- é alterada para:

let y = 94 in do y' <- print y
                 x' <- x
                 g' <- g y' x'
                 f g'