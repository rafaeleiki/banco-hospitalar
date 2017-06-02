require_relative '_relations'

base_path = "./seeds/"
full_sql = []

RELATIONS.each do |relation_name|
  file = File.open("#{base_path}#{relation_name}.sql", 'r')
  full_sql.push("--#{relation_name}")
  full_sql.push(file.read)
end

output_file = File.open('./generated_seed.sql', 'w')
output_file.write(full_sql.join("\n"))
