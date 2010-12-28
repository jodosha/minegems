Feature: Sign up
  In order to get access to protected sections of the site
  A user
  Should be able to sign up

    Scenario: User signs up with invalid email
      When I go to the sign up page
      And I fill in "Name" with "jodosha"
      And I fill in "Email" with "invalidemail"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with invalid name
      When I go to the sign up page
      And I fill in "Name" with ""
      And I fill in "Email" with "jodosha@gemsmineapp.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with already taken name
      Given An user signed up with "jodosha" name
      When I go to the sign up page
      And I fill in "Name" with "jodosha"
      And I fill in "Email" with "jodosha@gemsmineapp.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with invalid password
      When I go to the sign up page
      And I fill in "Name" with "jodosha"
      And I fill in "Email" with "jodosha@gemsmineapp.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with ""
      And I press "Sign up"
      Then I should see error messages

    Scenario: User signs up with valid data
      When I go to the sign up page
      And I fill in "Name" with "jodosha"
      And I fill in "Email" with "email@person.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I press "Sign up"
      Then I should see "You have signed up successfully. A confirmation was sent to your e-mail."
      And a confirmation message should be sent to "email@person.com"

    Scenario: User confirms his account
      Given I signed up with "email@person.com/password"
      When I follow the confirmation link sent to "email@person.com"
      Then I should see "Your account was successfully confirmed. You are now signed in."
      And I should be signed in
