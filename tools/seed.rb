base_path = "./seeds/"
files = %w(pessoa matricula_area paciente profissional_saude remedio
           medico enfermeiro enfermidade descricao_remedio)
full_sql = []

files.each do |file_name|
  file = File.open("#{base_path}#{file_name}.sql", 'r')
  full_sql.push("--#{file_name}")
  full_sql.push(file.read)
end

seed_file = File.open('./seed.sql', 'w')
seed_file.write(full_sql.join("\n"))
