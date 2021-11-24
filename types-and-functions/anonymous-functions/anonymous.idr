-- Temos outras maneiras para escrever a expressão a cima,
-- Uma delas podemos utilizar funções anonimas:

-- show (map (\x => x * 2) intVec)

-- A notação \x -> val constroi uma função anonima
-- que recebe um argumento, x e retorna a expressão val.
-- Funções anonimas talvez recebam varios agumentos,
-- separados por virgula, e.g.: \x, y, z => val.
-- Argumentos talvez possam ter uma tipo explicito, e.g:
-- \x:Int -> x * 2., e pode ter pattern matching, e.g:
-- \(x, y) => x * y. Nós podemos também usar uma seção de operador
 
-- show (map (* 2) intVec)

-- (* 2) é uma pequena implementação para a função que multiplica 
-- um número por dois. Isso expande para \x => x * 2.
-- Similarment, (2*) pode expandir para \x => 2 * x.