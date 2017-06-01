base_path = "./queries/"
queries_files = %w(anamnese consulta paciente profissional)
full_sql = []

queries_files.each do |file_name|
  file = File.open("#{base_path}#{file_name}.sql", 'r')
  full_sql.push('')
  full_sql.push(file.read)
end

output_file = File.open('./generated_queries.sql', 'w')
output_file.write(full_sql.join("\n"))
