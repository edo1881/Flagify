Feature: User can login in website

Scenario: As an unregistred user i want to Signup
    Given I am on the Flagify home page
    When I follow "Signup"
    Then I should be on the signup page
    When I fill in "email" with "admin@admin.it" 
    And I fill in "password" with "12345678"
    And I fill in "password_confirmation" with "12345678"
    And I press "signup"
    Then I should be on the Flagify home page

Scenario: As a registred player i want to become a creator and create a challenge
    # Given I am a registered user as "player@gmail.it", "12345678", 1
    Given I am on the Flagify home page
    When I follow "Signup"
    Then I should be on the signup page
    When I fill in "email" with "player@admin.it" 
    And I fill in "password" with "12345678"
    And I fill in "password_confirmation" with "12345678"
    And I press "signup"
    Then I should be on the Flagify home page
    When I follow "button_profile"
    Then I should be on the profile page 1
    And I should see "Become a creator"
    Then I follow "become_creator"
    Then I should be on the create challenge page
    And I fill in "nome" with "test challenge"
    And I fill in "category" with "test category"
    And I fill in "testo" with "testo"
    And I fill in "hint" with "hint test"
    And I fill in "flag" with "flag"
    # Then show me the page
    # When I press "commit"
    # Then I should be on the challenges page
    # Then I should see "test"

Scenario: I wanto to solve a challenge
    Given I am a registered user as "player@gmail.it", "12345678", 1
    And I follow "challenges"
    Then I should be on the challenges page
    # Then show me the page
    When I press card "1"
    # Then I follow "/challenges/1"