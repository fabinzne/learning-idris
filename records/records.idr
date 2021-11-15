import Data.Vect

-- Records são tipos de dados que coletam diversos valores
-- (os campos de um registro) juntos. Idris forncece uma
-- sintaxe para definir records e automaticamente gerar
-- acesso a campos e funções de atualização. Diferente da
-- sintaxe usada para estrutura de dados, records em Idris
-- seguem uma sintaxe diferente daquela vista em Haskell.
-- Por exemplo, podemos representar um nome de uma pessoa
-- e idade em um registro:

record Person where
  constructor MkPerson
  firstName, middleName, lastName : String
  age : Int

fred : Person
fred = MkPerson "Fred" "Joe" "Bloggs" 30

-- O nome do construtor é fornecido usando o operador
-- constructor, e os campos são dados usando identação
-- seguindo do where (firstName, middleName, lastName).
-- Você pode declarar multiplos campos em uma unica linha
-- informando que eles possuem o mesmo tipo. O nome dos campos
-- podem ser utilizados para acessar os valores deles:

-- *Record> fred.firstName
-- "Fred" : String
-- *Record> fred.age
-- 30 : Int
-- *Record> :t (.firstName)
-- Main.Person.(.firstName) : Person -> String

-- Nós podemos utilizar prejeções de prefixo como em Haskell:

-- *Record> firstName fred
-- "Fred" : String
-- *Record> age fred
-- 30 : Int
-- *Record> :t firstName
-- firstName : Person -> String

-- Projeções por prefixo podem ser desabilitados por um registro
-- utilizando o pragma %prefix_record_projections off, que faz
-- todos as subsequentes denições de records apenas usarem
-- projeções com pronto (.). Esse pragma tem seu efeito até
-- o final do modulo ou até o fechamento de sua ocorrencia
-- com %prefix_record_projections on

-- Nós também podemos utilizar o nome dos campos para
-- atualizar um record (ou, mais precisamento, produzir uma
-- cópia do record com os valores atualizados):

-- *Record> record { firstName = "Jim" } fred
-- MkPerson "Jim" "Joe" "Bloggs" 30 : Person
-- *Record> record { firstName = "Jim", age $= (+ 1) } fred
-- MkPerson "Jim" "Joe" "Bloggs" 31 : Person

-- A sintaxe record { field = value } gera uma função que
-- atualiza os campos dados de um registro. = adiciona
-- um novo valor para o campo e $= adiciona uma função que
-- atualiza o valor do campo.

-- Cada regristro é definido em seu proprio namespace, o que
-- significa que os nomes dos campos podem ser reutilizados
-- em varios registros.

-- Registros e campos sem registros, podem ter tipos dependentes
-- Atualizações são aceitar para alterar o tipo de um campo
-- fornecendo que o resultado é bem tipado.

record Class where
  constructor ClassInfo
  students : Vect n Person
  className : String

-- Isso é seguro para atualizar o campos estudantes com um
-- vetor de tamanhos diferentes porque isso não vai afetar
-- o tipço do registro:

addStudent : Person -> Class -> Class
addStudent p c = record { students = p :: students c } c

-- *Record> addStudent fred (ClassInfo [] "CS")
-- ClassInfo [MkPerson "Fred" "Joe" "Bloggs" 30] "CS" : Class

-- Nós também podemos utilizar $= para definir addStudent
-- de forma mais conscisa:

addStudent' : Person -> Class -> Class
addStudent' p c = record { students $= (p ::) } c

-- Projeção misturada

-- Campos de registros mistos podem ser acessados utilizando
-- a notação de ponto (.):

-- x.a.b.c
-- map (.a.b.c) xs

-- Para a notação de pontos, não podem haver espaços após
-- os pontos mas talvez possam haver espaços antes dos pontos.
-- A projeção por composilão deve ser utilizada com parênteses
-- se não map .a.b.c xs pode ser entendido como map.a.b.c xs.

-- Os campos de registros mistos podem ser acessados utilizando
-- a notação de prefixo também:

-- (c . b . a) x
-- map (c . b . a) xs

-- Pontos com espaços ao redor deles representam operadores
-- de composição de funções.

-- Atualização de registros mistos

-- Idris também fornece uma sintaxe conveniente para acessar
-- e atualizar campos de registros mistos. Por exemplo, se
-- um campo é acessivel com a expressão x.a.b.c, então
-- isso pode ser atualizado utilizando a seguinte sintaxe:

-- record { a.b.c = val } x

-- Isso retorna um novo registro, com o campos acessado por
-- a.b.c setado para val. A sintaxe é First Class, i.e.
-- record { a.b.c = val } por si só tem um tipo de uma função

-- A notação $= também é valida para atualizar registros mistos

