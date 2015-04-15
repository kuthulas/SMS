Feature: Admin Sign in
  In order to get access to protected sections of the site
  A admin
  Should be able to sign in

    Scenario: admin is not signed up
      Given I do not exist as a admin
      When I sign in with valid credentials as admin
      Then I see an invalid login message
        And I should be signed out as admin

    Scenario: admin signs in successfully
      Given I exist as a admin
        And I am not logged in as admin
      When I sign in with valid credentials as admin
      Then I see a successful sign in message as admin
      When I return to the site
      Then I should be signed in as admin

    Scenario: admin enters wrong password
      Given I exist as a admin
      And I am not logged in as admin
      When I sign in with a wrong password as admin
      Then I see an invalid login message
      And I should be signed out as admin

      
