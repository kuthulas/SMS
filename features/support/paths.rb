# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the Seminar Management System home page/
      '/users/sign_in'
    when /^the Admin Login page/
      '/admins/sign_in'
    when /^Admin Login/
      '/admins/sign_in'
    when /^Admin Logout/
      '/admins/sign_out'
    #when /^the Admin Logout page/
     # '/admins/sign_out'
    when /^the Seminar Management System home page/
      '/users'
    when /^the home page/
      '/'
    when /^the Admin home page/
       '/admins/sign_in'
    when /^the Admin home page/
       '/events'
    when /^the Events page/
       '/events'
    when /^Staff Login/
       '/users/sign_in'
    when /^the Staff Login page/
       '/users/sign_in'
    when /^the Staff home page/
       '/users/sign_in'
    when /^Staff Logout/
       '/users/sign_out'
    when /^Home/
       '/'
    when /^New Event/
       '/events/new'
    when /^the New Event page/
       '/events/new'
    when /^Events/
       '/events'
    when /^Students/
       '/students'
    when /^New Student/
       '/students/new'
    when /^Check-in/
       '/events/1/check'
    when /^Import/
       '/students/import'
    when /^Cards/
       '/cards/index'
    when /^Manage Users/
       '/users'
    when /^New User/
       '/users/sign_up'
    when /^Reports/
       '/checkins'
    when /^Download/
       '/checkins.csv'
    when /^Browse.../
       ''
    when /^Logout/
       '/admins/sign_out'
    when /^New Checkin/
       '/checkins/new'
    when /^Import/
       '/cards/import'
    when /^Edit/
       '/events/1/edit'
    when /^Destroy/
       'events/1'
    when /^Show/
       'students/1'
    
    
  # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
