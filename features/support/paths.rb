module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /the homepage/
      root_path
    when /the sign up page/
      new_user_registration_path
    when /the "(.*)" subdomain/
      root_url(:host => "#{$1}.#{$host}:#{$port}")
    when /the new gem page/
      new_gem_path
    when /the gems page/
      gems_path
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
