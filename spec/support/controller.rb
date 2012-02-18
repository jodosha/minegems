module RspecSupportController

  module Helpers

    # Logins as +user+.
    #
    # Returns the User instance.
    def login(user = nil)
      (user || FactoryGirl.create(:user, email: "login@example.com")).tap do |current|
        sign_in current
      end
    end

    def login_and_subdomain
      user      ||= FactoryGirl.create(:user, email: "mine@example.com")
      user.confirm!
      subdomain ||= FactoryGirl.create(:subdomain, tld: "mine")
      user.subdomains << subdomain

      request.host = "#{subdomain.tld}.test.host"
      sign_in user

      [user, subdomain]
    end

  end

  module Macros

    def should_require_login(*args)
      options = args.extract_options!
      method  = options.delete(:method) || :get

      args.each do |action|
        specify "#{method.to_s.upcase} #{action} requires login" do
          if options[:xhr]
            xml_http_request method, action, options
            response.should be_unauthorized
          else
            send method, action, options
            should redirect_to new_user_session_url
          end
        end
      end
    end

  end

end

RSpec.configure do |config|
  config.include RspecSupportController::Helpers
  config.extend RspecSupportController::Macros
end
