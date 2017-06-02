require_relative '_relations'

base_path = "./queries/"
full_sql = []

def remove_functions(content)
  content.gsub(/CREATE OR REPLACE FUNCTION.*;/m, "\n")
end

QUERIES_FILES.each do |file_name|
  file = File.open("#{base_path}#{file_name}.sql", 'r')
  full_sql.push('')
  content = file.read
  full_sql.push(remove_functions(content))
end

output_file = File.open('./generated_queries.sql', 'w')
output_file.write(full_sql.join("\n"))
