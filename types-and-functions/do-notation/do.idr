-- Programas I/O tipicamente vão necessitar de uma sequencia
-- de ações, adicionando o output de uma computação
-- no output da proxima. IO é um tipo abstrato, de qualquer forma
-- não podemos acessar o resultado da computação diretamente
-- ao invés disso, nós executamos as operações sequencialmente
-- usando a notação "do":

greet : IO ()
greet = do putStr "What is your name? "
           name <- getLine
           putStr ("Hello " ++ name)

-- A sintaxe x <- iovalue executa a operação I/O iovalue,
-- do tipo IO a, e adiciona o resultado do tipo a na variavel
-- x. Nesse caso, getLine retorna um IO String, então name
-- possui o tipo String. Identação é importante, cada
-- definição do bloco deve começar na mesma coluna.
-- A operação pure permite injetar um valor dentro
-- de uma operação IO

pure : a -> IO a

-- Como vamos ver futuramente, a notação do é mais abrangente
-- que isso e pode ser sobrecarregada.

-- Você pode tentar executar geet no REPL do idris2 rodando
-- o comando :exec greet


main : IO ()
main = greet
