# banco-hospitalar

Para gerar o arquivo de seed, execute (a partir da pasta raiz):

`ruby tools/seed.rb`

A ordem é definida em `tools/_relations.rb`.

Para gerar o arquivo de rollback dos seeds (apaga todas as linhas do banco):

`ruby tools/seed_rollback.rb`

Em ambos os casos, um arquivo `generated_*.sql` com a descrição do tipo
de operação feita será gerado.

