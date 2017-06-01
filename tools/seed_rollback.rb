require_relative '_relations'

base_path = "./seeds/"
full_sql = []

RELATIONS.reverse.each do |relation_name|
  full_sql.push("DELETE FROM #{relation_name};")
end

seed_file = File.open('./generated_seed_rollback.sql', 'w')
seed_file.write(full_sql.join("\n"))
