namespace :db do
  desc "Create 100 users with random names and descriptions"
  task :create_user => :environment do
  require 'populator'
  require 'faker'

  password = '23219217'

    User.populate 100 do |user|
      user.username = Faker::Name.name
      user.sign_in_count = 0
      
      user.encrypted_password = User.new(:password => password).encrypted_password
      user.email = Faker::Internet.email
      user.address = 'MEM-' + Faker::Address.country + Faker::Address.city + Faker::Address.street_name + Faker::Address.zip
      user.address_to_receive = 'REC-' + Faker::Address.country + Faker::Address.city + Faker::Address.street_name + Faker::Address.zip
      user.tel = Faker::PhoneNumber.phone_number 
      #user.about = Faker::Lorem.sentence(word_count = 20, supplemental = false, random_words_to_add = 10)
      puts user.email
    end
    puts 'All done'
  end
end