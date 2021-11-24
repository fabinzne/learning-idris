-- Em idris temos uma diferença entre funções totais e 
-- funções parciais. Uma função total é uma função que
-- condiz com dos seguintes fatores:

-- Terma para todos os possiveis inputs, ou
-- produz um não-vazio, finito, prefixo de uma possibilidade
-- de um resultado infinito.

-- Se uma função é total, nós podemos considerar seu tipo
-- como uma descrição precisa do que a função irá fazer.
-- Por exemplo, se temos uma função que retorna o tipo String
-- nós sabemos algo diferente, dependendo se é ou não total

-- Se ela é total, isso vai retornar um valor do tipo String
-- em um tempo finito;

-- Se parcial, então contanto que não quebre ou entre em um
-- loop infinito, isso vai retornar uma String

-- Idris faz essa distinguição para saber se a função é segura
-- para validar enquanto os tipos são checados (como vimos
-- em Fist Class Types). Depois de tudo, se tenta validar
-- a função que não termina durante a checagem dos tipos,
-- então a checagem do tipo não termina. Funções pariciais
-- podem continuar sendo usadas em tipos, mas ele não vai ser
-- avaliado.