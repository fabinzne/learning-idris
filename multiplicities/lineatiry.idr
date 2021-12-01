-- A multiplicidade 1, expressa que a variavel deve ser utilizada
-- apenas uma vez, ao dizer "usada", nós dizemos tando:

-- -> Se a variavel é im tipo de dado ou valor primitivo, ela é
--    pattern matched novamente. Ex, sendo o subject de um case
--    ou um argumento de uma função que possui pattern match against

-- -> Se a variavel é uma função, essa função é aplicada (ex:
--    corre com uma argumento)

-- Primeiro, nós vamos ver como isso funciona em alguns exemplos
-- pequenos de fuções e tipos de dados, então vamos ver como
-- isso pode ser usado para encodar resource procols

-- Acima nós vimos o tipo de duplicate. Vamos tentar escrever
-- isso interativamente e ver o que acontece de errado. Nós vamos
-- começar pelo tipo e a definição de um esqueleto com uma buraco:

-- duplicate : (1 x : a) -> (a, a)
-- duplicate x = ?help 

-- Checar o tipo de um buraco nos diz a multiplicidade de cada
-- variavel no escopo. Se nós checarmos o tipo de ?help nós vamos
-- ver que não podemos usar a em run-time, e nós podemos
-- utilizar x exatamente uma vez

-- Se utilizarmos para uma parte do par...

-- duplicate : (1 x : a) -> (a, a)
-- duplicate x = (?help, x)

-- Então o tipo do buraco sobrando nos diz que não podemos utilizar
-- ele para o outro

-- O mesmo acontece se nós definirmos duplicate x = (?help, x)

-- Em ordem para evitar ambiguidade do parser, se nós informamos
-- uma multiplicidade explicitamente para uma variavel com o
-- argumento de duplicate, você precisa fornecer o nome para isso
-- também. Mas se o nome não for utilizado no escopo de seu tipo
-- você pode usar _ no lugar do nome

duplicate : (1 _ : a) -> (a, a)

-- A intuição por tras de multiplicidade 1 é que nós temos uma
-- função com o seguinte tipo:

f : (1 x : a) -> b

-- Então idris irá compreender


-- Uma utilização similiar é aplicada para tipos de dados.
-- considerando o seguinte tipo, Lin que encapsula um argumento
-- que deve ser utilizado uma vez e Unr que encapsula um argumento
-- para uso restrito

data Lin : Type -> Type where
  MkLin : (1 _ : a) -> Lin a

data Unr : Type -> Type where
    MkUnr : a -> Unr a

-- Se MkLin x é utilizado uma vez, então x é utilizado uma vez também
-- mas se MkUnr x é utilizado uma vez, não existe nenhuma garantia
-- de quantas vezes x é usado. Nós podemos ver um pouco mais claro
-- se começarmos a escrever funções de projeção para Lin e Unr
-- para extrair o argumento

getLin : (1 _ : Lin a) -> a
getLin (MkLin x) = ?howmanyLin

getUnr : (1 _ : Unr a) -> a
getUnr (MkUnr x) = ?howmanyUnr

-- Checando o tipos dos buracos, nós vemos x exatamente uma vez
-- por que o argumento val é utilizado uma vez, por pattern matching
-- em MkLin x e se MkKin x é utilizado uma vez, então x também.

-- Para getUrn, então, nós temos que usar val mais uma vez contra
-- o pattern matching nela, mas se usar MkUnr x uma vez não coloca
-- nenhuma restrição em X. Etnaõ x é unrestrito e usa o corpo
-- de getUnr

-- Se getLin tiver argumentos unrestritor

-- Então x é unrestrito em howmanyLin:

-- Main> :t howmanyLin
--  0 a : Type
--    x : a
-- -------------------------------------
-- howmanyLin : a

-- Lembre-se que a intuição do tipo MkLink é que se MkLin x é utilizado
-- uma vez só, x é utilizado uma vez só. Mas se nós não falarmos
-- que MkLin x deve ser utilizado uma vez só, então não existem
-- restrições em x