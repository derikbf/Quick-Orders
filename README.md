# About
This project is the result of the first Hackaton of Rails Bootcamp prometed by [OneBiteCode](https://www.onebitcode.com).
The project proposal is a ordering system for a restaurant.

# Project
The project was built following the business rules from the Hackathon challenge.

![quick-orders](https://i.imgur.com/cTwawtl.gif)

# Technology stack
This is monolith application using 
- ruby on rails ``6.1.4.6``
- ruby ``2.7.1``
- postgresql
- bootstrap ``5.1.3``

# Mockup
The initial design concept was built on figma.
[Mockup](https://github.com/derikbf/Quick-Orders/blob/master/app/assets/images//mockup.pdf)

# Database diagram
![WhatsApp Image 2022-02-15 at 11 18 30](https://user-images.githubusercontent.com/15388320/154375251-0ba141d7-419e-4442-93d1-34a445ff7326.jpeg)

## Set up

1. Clone the project
```
git clone https://github.com/derikbf/Quick-Orders.git
```
```
cd Quick-Orders
```
2. Install dependencies
``` 
bundle install
``` 
``` 
yarn install || npm install
``` 

3. Database configuration 
The .env is responsible for configuring the postgres database.
Create a .env file on your rails root directory and configure the following environment variables:

![Config-file-env](https://uploaddeimagens.com.br/images/003/738/298/full/env.png)

and than execute 
``
rails db:setup
``

4. Create admin user with `rails create_user`. 
Enter rails console

```
rails c
```
 
```
User.create!(first_name: "Abc", last_name: "def", email: "abc@gmail.com", role: "admin", password: "Abc@123", password_confirmation: "Abc@123")
```
Role Options:
admin || mesero || chef 

5. Start the project
```
rails s
```
