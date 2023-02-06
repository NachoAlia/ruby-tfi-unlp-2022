# ER:
https://github.com/NachoAlia/ruby-tfi-unlp-2022/blob/main/app/assets/images/image1.png

# Required Installations:
```
1 .Ruby => 2.7.6
2 .Rails => 7.0.4
```
# Project Settings:
1. Clone this project to 'your destination'
```
cd 'your destination'
git clone https://github.com/NachoAlia/ruby-tfi-unlp-2022.git
```
2. Install dependencies:
```
cd 'ruby-tfi-unlp-2022'
bundle install
```
3. Run the migrations and seed.rb ( seed.rb contains test data for use in the project)
```
rails db:migrate
rails db:seed
```
4.  Run Server:  
```
rails s
navigate in your browser to: 'localhost:3000'
