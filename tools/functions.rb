require_relative '_relations'

base_path = "./queries/"
full_sql = []

def extract_functions(content)
  regex = /CREATE OR REPLACE FUNCTION.*;/m
  regex.match(content)
end

QUERIES_FILES.each do |file_name|
  file = File.open("#{base_path}#{file_name}.sql", 'r')
  full_sql.push('')
  content = file.read
  full_sql.push(extract_functions(content))
end

output_file = File.open('./generated_functions.sql', 'w')
output_file.write(full_sql.join("\n"))
