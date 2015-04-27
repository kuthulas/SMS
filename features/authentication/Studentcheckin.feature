Feature: Creating a New Event

Scenario: Create a Event
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
   When I sign out as admin
   Then I should see a signed out message 
   When I return to the site
   Then I should be signed out as admin
   Given I am logged in
   When I follow "Events"
   Then I should see "Listing Events"
   When I follow "Check-in"
   Then I should see "Swipe:"
   When I check "fast"
   When I fill in "card" with "1234567890"
 
