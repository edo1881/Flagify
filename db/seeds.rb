# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create! :id => 1, :email => "admin@admin.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 2, :email => "b@b.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 3, :email => "c@c.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 4, :email => "d@d.it", :password => "12345678", :password_confirmation => "12345678"
User.create! :id => 5, :email => "e@e.it", :password => "12345678", :password_confirmation => "12345678"


Challenge.create([  {id: 1, nome: "How to start", testo: "In questa serie di sfide, chiamate challenge, verranno introdotti alcuni concetti fondamentali riguardo alle competizioni Capture The Flag (CTF), in particolare del formato jeopardy. In ogni challenge ti verrà richiesto di trovare un''informazione segreta chiamata flag, sfruttando le vulnerabilità presenti all''interno della sfida. Trovando ed inviando la flag alla piattaforma otterrai dei punti in base alla difficoltà della sfida che ti farà salire in classifica. \nPer questa primissima challenge invia questa flag nel campo qua sotto: \nflag{My_f1R57_54Ni7Y_ch3Ck}", flag: "flag{My_f1R57_54Ni7Y_ch3Ck}", category: "Intro", hint: "Scrivi flag{My_f1R57_54Ni7Y_ch3Ck}", score: 100, user_id: 1}, 
                    {id: 2, nome: "How to start: suggerimenti", testo: "Quando sei bloccato sulla risoluzione di una challenge, puoi provare ad aprire i suggerimenti (hint) che possono essere presenti.\nStai attento: i suggerimenti possono costare dei punti!\nLa flag è all'interno del suggerimento di questa challenge.", flag: "flag{My_s3c0nd_54Ni7Y_ch3Ck}", category: "Intro", hint: "flag{My_s3c0nd_54Ni7Y_ch3Ck}", score: 100, user_id: 1},
                    {id: 3, nome: "Tutte le strade portano a Roma", testo: "Su un'antica pergamena è stata trovata questa citazione. \nProva a decriptarla: \ncixd{xsb_zxbpxo_jlofqrof_qb_pxirqxkq}", flag: "flag{ave_caesar_morituri_te_salutant}", category: "Crypto", hint: "Utilizza il cifrario di Cesare", score: 100, user_id: 1},  
                    {id: 4, nome: "Classic Cipher", testo: "Ciphertext: xcqv{gvyavn_zvztv_etvtddlnxcgy}", flag: "flag{simple_rotor_bruteforcing}", category: "Crypto", hint: "Cryptography,Utilizza il cifrario di Cesare con una rotazione", score: 100, user_id: 1},
                    {id: 5, nome: "Very strong Vigenere", testo: "Da quando ho scoperto vigenere mi sento completamente al sicuro! \nCiphertext: fzau{ncn_isors_cviovw_pwcqoze}", flag: "flag{non_usare_chiavi_piccole}", category: "Crypto", hint: "Utilizza il cifrario di Vigenere con una chiave di quattro lettere", score: 200, user_id: 1},                     
                    {id: 6, nome: "Password Cracker", testo: "Puoi crackare la password? Scarica il password checker <a href=\"#\" download=\"crack.py\" target=\"_blank\">qui</a> e avrai bisogno della <a href=\"#\" download=\"flag.txt.enc\" target=\"_blank\">flag</a>  cifrata nella stessa directory", flag: "{545h_r1ng1ng_fa343060}", category: "Reverse Engineering", hint: "Controlla la password per la flag", score: 100, user_id: 1},  
                    {id: 7, nome: "Python reverse", testo: "Il '<a href=\"#\" download=\"\" target=\"_blank\">file</a> è stato cifrato con <a href=\"\" download=\"encrypt.py\" target=\"_blank\">'questo</a>  file, riuscirai a defifrarlo?", flag: "flag{but_1_th0ught_Dlog_wa5_h4rd}", category: "Reverse Engineering", hint: "La chiave di cifratura va tra 0 e 255, ma ricorda che la flag ha sempre lo stesso formato ;)", score: 200, user_id: 1},  
                    {id: 8, nome: "Challenge 8", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1},  
                    {id: 9, nome: "Challenge 9", testo: "Prova a risolvere questa terza challenge", flag: "flag", category: "Web", hint: "Scrivi flag", score: 100, user_id: 1},  
])


UserChallenge.create! :id => 1, :flag_timestamp => "2022/09/08 16:30:27", :user_id => 2, :challenge_id => 1
UserChallenge.create! :id => 2, :flag_timestamp => "2022/09/08 12:31:02", :user_id => 2, :challenge_id => 2
UserChallenge.create! :id => 3, :flag_timestamp => "2022/08/02 18:24:42", :user_id => 2, :challenge_id => 4
UserChallenge.create! :id => 4, :flag_timestamp => "2022/08/22 20:49:32", :user_id => 2, :challenge_id => 8
UserChallenge.create! :id => 5, :flag_timestamp => "2022/08/01 13:28:15", :user_id => 2, :challenge_id => 3
UserChallenge.create! :id => 6, :flag_timestamp => "2022/07/14 15:05:02", :user_id => 3, :challenge_id => 9
UserChallenge.create! :id => 7, :flag_timestamp => "2022/07/27 17:39:57", :user_id => 3, :challenge_id => 1
UserChallenge.create! :id => 8, :flag_timestamp => "2022/06/20 18:34:25", :user_id => 4, :challenge_id => 4
