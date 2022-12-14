
Feature: User can login in website

Scenario: As an unregistered user i want to Signup
    Given I am on the Flagify home page
    When I follow "Signup"
    Then I should be on the signup page
    When I fill in "email" with "admin@admin.it" 
    And I fill in "password" with "12345678"
    And I fill in "password_confirmation" with "12345678"
    And I press "signup"
    Then I should be on the Flagify home page

 Scenario: As a registered player i want to become a creator and create a challenge
     Given I am on the Flagify home page
     When I follow "Signup"
     Then I should be on the signup page
     When I fill in "email" with "player@admin.it" 
     And I fill in "password" with "12345678"
     And I fill in "password_confirmation" with "12345678"
     And I press "signup"
     #Given I am a registered user as "player@admin.it", "12345678", 1

     Then I should be on the Flagify home page
     When I follow "button_profile"
     Then I should be on the profile page 1
     And I should see "Become a creator"
     Then I follow "become_creator"
     Then I should be on the create challenge page
     And I fill in "challenge_nome" with "test challenge"
     And I fill in "challenge_category" with "test category"
     And I fill in "challenge_testo" with "testo"
     And I fill in "challenge_hint" with "hint test"
     And I fill in "challenge_flag" with "flag"
     #And I submit "test challenge", "test category", "testo", "hint test", "flag", "100"
     And I press "submit"
#     # And show me the page
#     # And I follow "challenges"
    #  Then I should be on the challenges page
#     And I should see "test challenge"
    
Scenario: I want to solve a challenge
    Given I am a registered user as "player@admin.it", "12345678", 1
    And I follow "challenges"
    Then I should be on the challenges page
    # since jQuery doesn't work with cucumber
    Given I am on the first challenge page  

    And I fill in "flag" with "flag{My_f1R57_54Ni7Y_ch3Ck}"
    And I press "btn_flag"
    Then I should see "You solved the challenge"
