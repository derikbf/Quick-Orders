desc "Cria o primeiro usuario"
task create_user: :environment do
  puts "Digite o nome do usuario:"
  name  = STDIN.gets.chomp
  puts "Digite o email do usuario:"
  email = STDIN.gets.chomp
  puts "Digite a senha do usuario:"
  senha = STDIN.gets.chomp

  ActiveRecord::Base.transaction do
    User.create!(name: name, email: email, password: senha, role: 1)
  end
end
