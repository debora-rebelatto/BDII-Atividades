-- se o produto em estoque chegar ao valor 0 (não tem mais o produto) então o mesmo deve ser removido das tabelas Product e Stock. A aplicação faz o controle para o caso de quantity<=0. 
-- if product reaches 0, remove from tables Product and Stock
-- if quantity<=0, the application will control it
DELETE FROM Product WHERE id NOT IN (SELECT product_id FROM Stock);
