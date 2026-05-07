# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Vet.destroy_all
Owner.destroy_all

owners = [
  Owner.create!(
    first_name: "Maria",
    last_name: "Guerra",
    email: "maria.guerra@example.com",
    phone: "+56911111111",
    address: "Cerro el Paico 9886, Santiago"
  ),
  Owner.create!(
    first_name: "Antonio",
    last_name: "Ossa",
    email: "antonio.ossa@example.com",
    phone: "+56922222222",
    address: "Camino la Tagua 3627, Valparaiso"
  ),
  Owner.create!(
    first_name: "Sofia",
    last_name: "Martinez",
    email: "sofia.martinez@example.com",
    phone: "+56933333333",
    address: "Camino las hermitas 2431, Concepcion"
  )
]

pets = [
  owners[0].pets.create!(
    name: "Luna",
    species: "dog",
    breed: "Labrador",
    date_of_birth: Date.new(2020, 5, 10),
    weight: 24.5
  ),
  owners[0].pets.create!(
    name: "Milo",
    species: "cat",
    breed: "Siamese",
    date_of_birth: Date.new(2021, 8, 15),
    weight: 4.2
  ),
  owners[1].pets.create!(
    name: "Bella",
    species: "rabbit",
    breed: "Mini Lop",
    date_of_birth: Date.new(2022, 3, 20),
    weight: 2.1
  ),
  owners[1].pets.create!(
    name: "Rocky",
    species: "dog",
    breed: "Beagle",
    date_of_birth: Date.new(2019, 11, 2),
    weight: 12.8
  ),
  owners[2].pets.create!(
    name: "Nala",
    species: "cat",
    breed: "Persian",
    date_of_birth: Date.new(2018, 7, 1),
    weight: 5.0
  )
]
seed_photos = [
  [pets[0], "dog.jpg"],
  [pets[1], "cat.jpg"],
  [pets[2], "rabbit.jpg"],
  [pets[3], "dog.jpg"],
  [pets[4], "cat.jpg"]
]

seed_photos.each do |pet, filename|
  path = Rails.root.join("db/seeds/pets/#{filename}")

  if File.exist?(path)
    pet.photo.attach(
      io: File.open(path),
      filename: filename,
      content_type: "image/jpeg"
    )
  else
    puts "Missing seed image: #{path}"
  end
end

vets = [
  Vet.create!(
    first_name: "Ana",
    last_name: "Rojas",
    email: "ana.rojas@vetclinic.com",
    phone: "+56944444444",
    specialization: "General Practice"
  ),
  Vet.create!(
    first_name: "Carlos",
    last_name: "Fernandez",
    email: "carlos.fernandez@vetclinic.com",
    phone: "+56955555555",
    specialization: "Surgery"
  )
]

appointments = [
  Appointment.create!(
    pet: pets[0],
    vet: vets[0],
    date: DateTime.new(2026, 4, 10, 10, 0, 0),
    reason: "Annual checkup",
    status: :scheduled
  ),
  Appointment.create!(
    pet: pets[1],
    vet: vets[1],
    date: DateTime.new(2026, 4, 11, 11, 30, 0),
    reason: "Skin irritation",
    status: :in_progress
  ),
  Appointment.create!(
    pet: pets[2],
    vet: vets[0],
    date: DateTime.new(2026, 4, 12, 9, 15, 0),
    reason: "Dental revision",
    status: :completed
  ),
  Appointment.create!(
    pet: pets[3],
    vet: vets[1],
    date: DateTime.new(2026, 4, 13, 14, 0, 0),
    reason: "Leg injury",
    status: :completed
  ),
  Appointment.create!(
    pet: pets[4],
    vet: vets[0],
    date: DateTime.new(2026, 4, 14, 16, 45, 0),
    reason: "Vaccination follow-up",
    status: :cancelled
  )
]

Treatment.create!(
  appointment: appointments[1],
  name: "Skin Cream Application",
  medication: "Hydrocortisone Cream",
  dosage: "Apply twice daily",
  notes: "Monitor redness and itching",
  administered_at: DateTime.new(2026, 4, 11, 11, 45, 0)
)

Treatment.create!(
  appointment: appointments[2],
  name: "Teeth Cleaning",
  medication: "Dental Rinse",
  dosage: "5 ml after cleaning",
  notes: "Procedure completed successfully",
  administered_at: DateTime.new(2026, 4, 12, 9, 45, 0)
)

Treatment.create!(
  appointment: appointments[2],
  name: "Pain Relief",
  medication: "Meloxicam",
  dosage: "0.2 mg/kg once daily",
  notes: "Given after dental procedure",
  administered_at: DateTime.new(2026, 4, 12, 10, 0, 0)
)

Treatment.create!(
  appointment: appointments[3],
  name: "Bandage Placement",
  medication: "Antiseptic Solution",
  dosage: "Clean area before bandage",
  notes: "Bandage should be changed in 3 days",
  administered_at: DateTime.new(2026, 4, 13, 14, 30, 0)
)

Treatment.create!(
  appointment: appointments[3],
  name: "Anti-inflammatory Injection",
  medication: "Carprofen",
  dosage: "1 injection",
  notes: "Pet responded well",
  administered_at: DateTime.new(2026, 4, 13, 14, 40, 0)
)

puts "Seed data created successfully!"
puts "#{Owner.count} owners"
puts "#{Pet.count} pets"
puts "#{Vet.count} vets"
puts "#{Appointment.count} appointments"
puts "#{Treatment.count} treatments"