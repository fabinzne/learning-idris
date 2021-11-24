-- Por padrão, parametros que não sou explicitamente atribuidos
-- a um tipo em uma declaração de interface, são marcados
-- com a quantidade 0. Isso significa que o parametro não
-- está disponivel para uso durante o tempo de execução
-- na declaração do método.

-- Para instanciar, Show a recebe um 0=quantitativo como tipo
-- da variavel a, no tipo do método show:

-- Main> :set showimplicits
-- Main> :t show
-- Prelude.show : {0 a : Type} -> Show a => a -> String

-- De qualquer forma, alguns casos requerem que os parametros
-- estejam disponiveis em tempo de execução. Talvez paraa uma
-- instancia que queira declarar uma interface para tipos 
-- Storable. A restrição Storable a size significa
-- que podemos guardar valores do tipo a em um Buffer
-- exatamente no tamanho (size) de bytes.

-- Se o usuario fornecer um método para ler o valor do tipo a
-- em um offset definido, então nós podemos ler o elemento
-- k guardado no buffer computando o apropriado offset de k
-- e de size. Isso demonstra chamando uma implementação padrão
-- para o método peekElementOff, implementado em termos de 
-- peekByteOff e o parametro size.

data ForeignPtr : Type -> Type where
  MkFP : Buffer -> ForeignPtr a

interface Storable (0 a : Type) (size : Nat) | a where
  peekByteOff : HasIO io => ForeignPtr a -> Int -> io a

  peekElemOff : HasIO io => ForeignPtr a -> Int -> io a
  peekElemOff fp k = peekByteOff fp (k * cast size)

-- Note que a é explicitamente marcado como um tipo 
-- irrelevante em tempo de execução, então isso é apagado
-- pelo compilador. Equivalente nós poderiamos escrever

interface Storable' a (size : Nat).

-- O singificado de | a é explicado em Parametros Determinantes
