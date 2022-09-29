# Atividade 1 - Triggers

A partir do banco de dados (que está disponível na atividade), construa gatilhos para as seguintes funcionalidades:

1- se o produto em estoque chegar ao valor 0 (não tem mais o produto) então o mesmo deve ser removido das tabelas Product e Stock. A aplicação faz o controle para o caso de quantity<=0.

2- Para evitar problemas com uso indevido de medicamentos, crie uma tabela auxiliar de controle para armazenar quem está comprando cada medicamento com a data e hora. Ou seja, usuário que solicitou (logou no sistema- usar o current_user), hora, eid (tabela Product). Note que a aplicação irá fazer o update. O trigger deve apenas monitorar e armazenar as informações requisitadas.


Extract tar.xz file
```sql
tar -xvf homework.tar.xz
```

Run the following commands to create the database and the tables:
```sql
psql -h localhost -U postgres -d postgres -f homework.sql
```

Connect to the postgres:
```sql
sudo -i -u postgres
```

Connect to the database:
```sql
psql
\c homework
```