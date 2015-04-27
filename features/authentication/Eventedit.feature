Feature: Editing a New as a admin

Background: 
   Given I am logged in as admin
   When I follow "Events"
   Then I should see "Listing Events"
   When I follow "New Event"
   Then I should see "New Event"
   Then I should be on the New Event page
   When I fill in "Name" with "CSCE"
   When I fill in "Date" with "14-04-2015"
   When I fill in "Location" with "MSC"
   When I fill in "Time" with "04:00 PM"
   And I press "Create Event" 
   Then I should see "Event was successfully created."

Scenario: Edit an event
   Given I am logged in as admin
   When I follow "Events"
   Then I should see "Listing Events"
   When I follow "Edit"
   When I fill in "Location" with "Rudder Plaza"
   And I press "Update Event"
   Then I should see "Location: Rudder Plaza"
   Then I should see "Event was successfully updated."
   
   
