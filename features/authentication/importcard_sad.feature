Feature: Importing students as a admin, but should show an error as no file will be selected to import

Scenario: Students bulk import
   Given I am logged in as admin
   When I follow "Cards"
   Then I should see the Cards page
   Then I should see "Import Card Data"
   When I press "Import"
