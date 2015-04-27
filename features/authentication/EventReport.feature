Feature: Downloading list of as a admin

Scenario: Create a Event
   Given I am logged in as admin
   When I follow "Events"
   Then I should see "Listing Events"
   When I follow "Download"
   
