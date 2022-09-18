Given("I am a registered user as {string}, {string}, {int}") do |email, password, id|
    User.create(:email => email, :password => password, :password_confirmation => password, :id => id)
    User.create(:email => "admin@admin.it", :password => password, :password_confirmation => password, :id => 2, :role => "admin")

    Challenge.create([{id: 1, nome: "How to start", testo: "In questa serie di sfide, chiamate challenge, verranno introdotti alcuni concetti fondamentali riguardo alle competizioni Capture The Flag (CTF), in particolare del formato jeopardy. In ogni challenge ti verrà richiesto di trovare un''informazione segreta chiamata flag, sfruttando le vulnerabilità presenti all''interno della sfida. Trovando ed inviando la flag alla piattaforma otterrai dei punti in base alla difficoltà della sfida che ti farà salire in classifica. \nPer questa primissima challenge invia questa flag nel campo qua sotto: \nflag{My_f1R57_54Ni7Y_ch3Ck}", flag: "flag{My_f1R57_54Ni7Y_ch3Ck}", category: "Intro", hint: "Scrivi flag{My_f1R57_54Ni7Y_ch3Ck}", score: 100, user_id: 2}, 
                  {id: 2, nome: "How to start: suggerimenti", testo: "Quando sei bloccato sulla risoluzione di una challenge, puoi provare ad aprire i suggerimenti (hint) che possono essere presenti.\nStai attento: i suggerimenti possono costare dei punti!\nLa flag è all'interno del suggerimento di questa challenge.", flag: "flag{My_s3c0nd_54Ni7Y_ch3Ck}", category: "Intro", hint: "flag{My_s3c0nd_54Ni7Y_ch3Ck}", score: 100, user_id: 2}])
    visit user_session_path 
    fill_in "email", :with => email
    fill_in "password", :with => password
    click_button "login"
end

And("I submit {string}") do |flag|
    post "/challenges/check_flag", :params => {:flag => flag,format: :js}
end

And("I create a challenge with {string}, {string}, {string}") do |nome, categoria, flag|
    fill_in "nome", :with => nome
    fill_in "category", :with => categoria
    fill_in "flag", :with => flag
    click_button "commit"
end

When('I press card {string}') do |id|
    find_by_id(id,visible: false).click
end
