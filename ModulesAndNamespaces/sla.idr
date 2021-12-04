data Sabor = Morango | Chocolate

data Produto = Nil | S (Sabor) | List Sabor 

calcularPreco : Sabor -> Double
calcularPreco Morango = 1.50
calcularPreco Chocolate = 2.00

addProd : Produto -> Sabor -> Produto
addProd Nil prod = List prod
addProd list sabor = List sabor ++ List list 
-- main : IO ()
-- main = do
--     print (calcularPreco Morango) 
--     print (calcularPreco Chocolate)