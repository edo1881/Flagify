# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create! :id => 6, :email => "a@a.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 2, :email => "b@b.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 3, :email => "c@c.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 4, :email => "d@d.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 5, :email => "e@e.it", :password => "12345678", :password_confirmation => "12345678"


Challenge.create([  {id: 1, nome: "Challenge 1", testo: "Prova a risolvere questa prima challenge", flag: "flag", category: "Intro", hint: "Scrivi flag", score: 100, user_id: 1}, 
                    {id: 2, nome: "Challenge 2", testo: "Prova a risolvere questa seconda challenge", flag: "flag", category: "Intro", hint: "Scrivi flag", score: 100, user_id: 1},
                    {id: 3, nome: "Challenge 3", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Intro", hint: "Scrivi flag", score: 200, user_id: 1},  
                    {id: 4, nome: "Challenge 4", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Crypto", hint: "Scrivi flag", score: 100, user_id: 1},  
                    {id: 5, nome: "Challenge 5", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Crypto", hint: "Scrivi flag", score: 200, user_id: 1},  
                    {id: 6, nome: "Challenge 6", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Crypto", hint: "Scrivi flag", score: 100, user_id: 1},  
                    {id: 7, nome: "Challenge 7", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Web", hint: "Scrivi flag", score: 200, user_id: 1},  
                    {id: 8, nome: "Challenge 8", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1},  
                    {id: 9, nome: "Challenge 9", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1},  
])

UserChallenge.create! :id => 1, :flag_timestamp => "Sun, 04 Sep 2022 13:44:44.559994000 UTC +00:00", :user_id => 1, :challenge_id => 1
UserChallenge.create! :id => 2, :flag_timestamp => "Sun, 04 Sep 2022 13:44:45.559994000 UTC +00:00", :user_id => 1, :challenge_id => 2
UserChallenge.create! :id => 3, :flag_timestamp => "Sun, 04 Sep 2022 13:44:45.559994000 UTC +00:00", :user_id => 1, :challenge_id => 4
UserChallenge.create! :id => 4, :flag_timestamp => "Sun, 04 Sep 2022 13:44:45.559994000 UTC +00:00", :user_id => 1, :challenge_id => 8
UserChallenge.create! :id => 5, :flag_timestamp => "Sun, 04 Sep 2022 13:44:45.559994000 UTC +00:00", :user_id => 2, :challenge_id => 3
UserChallenge.create! :id => 6, :flag_timestamp => "Sun, 04 Sep 2022 13:44:45.559994000 UTC +00:00", :user_id => 2, :challenge_id => 9
UserChallenge.create! :id => 7, :flag_timestamp => "Sun, 04 Sep 2022 13:44:45.559994000 UTC +00:00", :user_id => 3, :challenge_id => 1
UserChallenge.create! :id => 8, :flag_timestamp => "Sun, 04 Sep 2022 13:44:45.559994000 UTC +00:00", :user_id => 4, :challenge_id => 4
