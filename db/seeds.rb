require 'json'

# Caminho para o arquivo JSON
file_path = Rails.root.join('db', 'car_data.json')

# Lendo e convertendo o JSON
car_data = JSON.parse(File.read(file_path))

# Inserindo os dados no banco de dados
car_data.each do |car|
  manufacturer = Manufacturer.find_or_create_by!(name: car["make"].capitalize)

  Car.create!(
    model: car["model"],
    year: car["year"],
    fuel_type: car["fuel_type"],
    manufacturer_id: manufacturer.id,
    city_mpg: car["city_mpg"],
    combination_mpg: car["combination_mpg"],
    cylinders: car["cylinders"],
    displacement: car["displacement"],
    drive: car["drive"],
    highway_mpg: car["highway_mpg"],
    transmission: car["transmission"],
    car_class: car["class"],
    created_at: Time.current,
    updated_at: Time.current
  )
end

puts "✅ Dados de carros importados com sucesso!"
