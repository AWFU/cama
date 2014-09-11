namespace :db do
  desc "Create 100 orderask with random orders and descriptions"
  task :create_orderask => :environment do
  require 'populator'
  require 'faker'

  #password = '23219217'
  orders_count = Order.where("aasm_state != 'hold' " ).count
    Orderask.populate 100 do |orderask|
      offset = rand(orders_count)
      rand_record = Order.first(:offset => offset)

      orderask.order_id = rand_record.id 
      orderask.description = Faker::Lorem.sentence(word_count = 20, supplemental = false, random_words_to_add = 10)
      orderask.status = ['new', 'done'].sample
      
      #user.about = 
      puts orderask.description
    end
    puts 'All done'
  end
end