Feature: Sign up
  In order to get access to protected sections of the site
  A user
  Should be able to sign up

    Scenario: User signs up with invalid email
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with "Luca Guidi"
      And I fill in "Username" with "jodosha"
      And I fill in "Email" with "invalidemail"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I fill in "Registration code" with "beefc0d3"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with invalid name
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with ""
      And I fill in "Username" with "jodosha"
      And I fill in "Email" with "jodosha@minege.ms"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I fill in "Registration code" with "beefc0d3"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with invalid nickname
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with "Luca"
      And I fill in "Username" with ""
      And I fill in "Email" with "jodosha@minege.ms"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I fill in "Registration code" with "beefc0d3"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with already taken domain name
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      And A subdomain with "company" tld
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with "Luca"
      And I fill in "Username" with "jodosha"
      And I fill in "Email" with "jodosha@minege.ms"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I fill in "Registration code" with "beefc0d3"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with invalid password
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with "Luca"
      And I fill in "Username" with "jodosha"
      And I fill in "Email" with "jodosha@minege.ms"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with ""
      And I fill in "Registration code" with "beefc0d3"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with invalid registration code
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with "Luca"
      And I fill in "Username" with "jodosha"
      And I fill in "Email" with "jodosha@minege.ms"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I fill in "Registration code" with "beefc0deee"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with non existent email
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with "Luca"
      And I fill in "Username" with "jodosha"
      And I fill in "Email" with "user@example.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I fill in "Registration code" with "beefc0d3"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with valid data
      Given an early bird registered with "jodosha@minege.ms/beefc0d3"
      When I go to the sign up page
      And I fill in "Name" with "Company Inc."
      And I fill in "Subdomain" with "company"
      And I fill in "Full name" with "Luca"
      And I fill in "Username" with "jodosha"
      And I fill in "Email" with "jodosha@minege.ms"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I fill in "Registration code" with "beefc0d3"
      And I press "Sign up"
      Then I should see "You have signed up successfully. A confirmation was sent to your e-mail."
      And a confirmation message should be sent to "jodosha@minege.ms"

    # Scenario: User confirms his account
    #   Given I signed up with "jodosha@minege.ms/password"
    #   When I follow the confirmation link sent to "jodosha@minege.ms"
    #   Then I should see "Your account was successfully confirmed. You are now signed in."
    #   And I should be signed in
