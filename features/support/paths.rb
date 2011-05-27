module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    #when /^the home\s?page$/
    #  '/'
    when /the homepage/
      root_url(:host => $host, :port => $port)
    when /the sign up page/
      new_user_registration_url
    when /the sign in page/
      new_user_session_path
    when /the "(.*)" subdomain/
      root_url(:host => "#{$1}.#{$host}", :port => $port)
    when /the "(.*)" new gem page/
      new_gem_url(:host => "#{$1}.#{$host}", :port => $port)
    when /the "(.*)" gems page/
      gems_url(:host => "#{$1}.#{$host}", :port => $port)
    when /the "(.*)" "(.*)" gem page/
      gem_url($2, :host => "#{$1}.#{$host}", :port => $port)
    when /the "(.*)" settings page/
      settings_url(:host => "#{$1}.#{$host}", :port => $port)
    when /the gems page/
      gems_path

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
