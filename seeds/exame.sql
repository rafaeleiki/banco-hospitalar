-- cod_procedimento, nome_arquivo, dados
INSERT INTO exame VALUES (56786, 'radiografia.jpg', pg_read_binary_file('import/radiografia.jpg')::bytea);
INSERT INTO exame VALUES (24805, 'eletrocardio.jpg', pg_read_binary_file('import/eletrocardio.jpg')::bytea);
INSERT INTO exame VALUES (43573, 'hemograma.jpg', pg_read_binary_file('import/hemograma.jpg')::bytea);
INSERT INTO exame VALUES (26489, 'uro.jpg', pg_read_binary_file('import/uro.jpg')::bytea);
INSERT INTO exame VALUES (87361, 'raio_perna.jpg', pg_read_binary_file('import/raio_perna.jpg')::bytea);
INSERT INTO exame VALUES (73859, 'ultra.jpg', pg_read_binary_file('import/ultra.jpg')::bytea);
INSERT INTO exame VALUES (49853, 'uabdomen.jpg', pg_read_binary_file('import/uabdomen.jpg')::bytea);
INSERT INTO exame VALUES (34783, 'eletrocard.pdf', pg_read_binary_file('import/eletrocard.pdf')::bytea);
INSERT INTO exame VALUES (32789, 'ressonancia.jpg', pg_read_binary_file('import/ressonancia.jpg')::bytea);

INSERT INTO exame(cod_procedimento) VALUES (12435);
INSERT INTO exame(cod_procedimento) VALUES (72940);
INSERT INTO exame(cod_procedimento) VALUES (92738);
INSERT INTO exame(cod_procedimento) VALUES (68933);
