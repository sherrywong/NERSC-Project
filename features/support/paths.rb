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

    when /^the login\s?page$/
      '/'

    when /^the project\s?page$/
      '/user/index'

    when /^the show users page$/
      '/user/show_users'

    when /^the My Profile page for "(.*)"$/
      uid = User.find_by_first($1).id
      "/user/#{uid}/edit"

    when /^the Add New User page$/
      '/user/new'
      
    when /^the project index page$/
      '/user/project/index'
      
    when /^the new project page$/
      '/user/project/new'

    when /^the project page for "(.*)"$/i
      "/project/#{Project.find_by_name($1).id}/edit"
      
    when /^(.*)'s Edit User page$/i
      "/user/#{User.find_by_username($1).id}/edit"

    when /^(.*)'s Add Risk page$/i
      "/user/project/#{Project.find_by_name($1).id}/risk/new"

    when /^the risk index page for (.*)$/i
      "/user/project/#{Project.find_by_name($1).id}/risk/index"

    when /^the Edit Risk page for (.*) in the first project$/i
      pid = Project.find_by_name("First Project").id
      rid = 0
      if Risk.find_by_title($1) == nil
        rid = Risk.find_by_title($1).object_id
      else
        puts "NOT"
        rid = Risk.find_by_title($1).id
      end
      "/user/project/#{pid}/risk/#{rid}/edit"
    
    when /^the Edit Risk page for (.*) in the second project$/i
      pid = Project.find_by_name("Second Project").id
      rid = 0
      if Risk.find_by_title($1) == nil
        rid = Risk.find_by_title($1).object_id
      else
        rid = Risk.find_by_title($1).id
      end
      "/user/project/#{pid}/risk/#{rid}/edit"

    when /^the Risk page for (.*) in the first project$/i
      pid = Project.find_by_name("First Project").id
      rid = 0
      if Risk.find_by_title($1) == nil
        rid = Risk.find_by_title($1).object_id
      else
        rid = Risk.find_by_title($1).id
      end
      "/project/#{pid}/risk/#{rid}"

    when /^the Risk page for (.*) in the second project$/i
      pid = Project.find_by_name("Second Project").id
      rid = 0
      if Risk.find_by_title($1) == nil
        rid = Risk.find_by_title($1).object_id
      else
        rid = Risk.find_by_title($1).id
      end
      "/project/#{pid}/risk/#{rid}"

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
