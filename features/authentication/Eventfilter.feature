Feature: Creating multiple events as admin

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
   Given I am logged in as admin
   When I follow "Events"
   Then I should see "Listing Events"
   When I follow "New Event"
   Then I should see "New Event"
   Then I should be on the New Event page
   When I fill in "Name" with "ECEN"
   When I fill in "Date" with "14-04-2015"
   When I fill in "Location" with "Rudder"
   When I fill in "Time" with "04:00 PM"
   And I press "Create Event" 
   Then I should see "Event was successfully created."
   Given I am logged in as admin
   When I follow "Events"
   Then I should see "Listing Events"
   When I follow "New Event"
   Then I should see "New Event"
   Then I should be on the New Event page
   When I fill in "Name" with "AERO"
   When I fill in "Date" with "14-04-2015"
   When I fill in "Location" with "HRBB"
   When I fill in "Time" with "04:00 PM"
   And I press "Create Event" 
   Then I should see "Event was successfully created."
   Given I am logged in as admin
   When I follow "Events"
   

