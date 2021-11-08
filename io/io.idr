-- I/O (Input/Output)

-- Programadas de computador são de  mal uso se não
-- interagem com o usuario ou com o sistema de alguma
-- forma. As dificuldades de linguagens puras que nem Idris
-- (O que é: uma linguagem que expressões não tem efeitos
-- colaterais) é que I/O é inerentemente um efeito colateral.
-- Então, Idris fornece um tipo Parametrizado IO que descreve
-- as interações que o sistema vai performar em tempo de
-- execussão, ao executar uma função.

data IO a 
-- descrição de uma operações IO retornando um valor do tipo a.

-- Nós vamos deixar a denição de IO abstrata, mas efetivamente
-- isso descreve o que operações I/O para serem executadas
-- são, em vez de como executar elas. As operações resultadas
-- são executadas externamente, pelo sistema run-time
-- Nós já vimos um programa I/O:

main: IO ()
main = putStrLn "Hello, world."

-- O tipo de putStrLn informa que ela recebe uma string
-- e retorna uma ação I/O que produz um elemento do tipo
-- de unidade (). Existe uma variante putStr que mostra
-- o output de uma string sem uma nova linha:

putStrLn : String -> IO ()
putStr : String -> IO ()

-- Nós também podemos ler string de um input de um usuario:

getLine : IO String

-- Uma gama de outras operações I/O estão disponiveis. Por
-- exemplo, adicionando "import System.File" para seu programa,
-- foce ganha acesso a funções para ler e escrever em arquivos.
-- Incluindo:

data File
-- abstrato
data Mode = Read | Write | ReadWrite

openFile : (f: String) -> (m: Mode) -> IO (Either FileError File)
closeFile : File -> IO ()

fGetLine : (h: File) -> IO (Either FileError String)
fPutStrl : (h: File) -> (str: String) -> IO (Either FileError ())
fEOF : File -> IO Bool

-- Note que muitas retornam Either, por elas poderem falhar.
