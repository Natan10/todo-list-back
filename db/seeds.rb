require 'faker'

#User.create(email: 'admin@admin',password:'123456')
#puts "#{User.first.id} criado."

20.times{
  puts "criando tasks...."
  Task.create!(
    name: Faker::Job.field,
    description: Faker::Lorem.sentence(word_count: 4),
    priority: [:urgente,:moderado,:relaxado].sample,
    status: [true,false].sample,
    user_id: User.first.id)
}

puts "Tasks criadas."