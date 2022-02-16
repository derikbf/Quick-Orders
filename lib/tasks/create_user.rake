desc "Create new User"
task create_user: :environment do
  puts "Type your first name:"
  first_name  = STDIN.gets.chomp

  puts "Type your last name:"
  last_name  = STDIN.gets.chomp

  puts "Type your email:"
  email = STDIN.gets.chomp

  puts "Type your password:"
  senha = STDIN.gets.chomp

  ActiveRecord::Base.transaction do
    User.create!(first_name: first_name, last_name: last_name, email: email, password: senha, role: 1)
  end
end
