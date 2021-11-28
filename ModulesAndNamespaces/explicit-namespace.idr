-- Denifir um modulo também define um namespace implicitamente.
-- De qualquer forma, namespaces podem também ser definidos
-- explicitamente. Isso é mais util se você quer carregar varios
-- namespaces dentro de um module:

-- module Foo

namespace X
    export
    test : Int -> Int
    test x = x * x

namespace Y
    export
    test : String -> String
    test x = x ++ x

-- Isso define um modulo com duas funções que possuem nomes qualificados
-- Foo.X.test e Foo.Y.test. que podem ser testadas pelo seu tipo

-- As regras de exportação, public export e export, são por namespace.
-- não por arquivos, então as duas definições de testes acima 
-- necessitam uma export flag para serem visiveis fora de seus
-- proprioes namespace
