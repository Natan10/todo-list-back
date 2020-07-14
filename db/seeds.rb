require 'faker'

puts "Criando usuários"

User.create!(email: "admin@admin.com",
            password: '123456789',
            password_confirmation: '123456789')


User.create!(email: "user1@user1.com",
            password: '123456789',
            password_confirmation: '123456789')

User.create!(email: "user2@user2.com",
             password: '123456789',
             password_confirmation: '123456789')

User.create!(email: "user3@user3.com",
              password: '123456789',
              password_confirmation: '123456789')

puts "Criando tasks..."

20.times{
  Task.create!(
    name: Faker::Job.field,
    description: Faker::Lorem.sentence(word_count: 4),
    priority: [:urgente,:moderado,:relaxado].sample,
    status: [true,false].sample,
    user_id: User.all.sample.id)
}

puts "Tasks criadas."