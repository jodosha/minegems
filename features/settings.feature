Feature: Settings
  In order to change my sensitive data
  As a user
  I want access to the settings page

  @javascript
  Scenario: User change their password
    Given I am authenticated as a "bootstrapp" member
    And I am on the "bootstrapp" settings page
    And I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "123456"
    And I press "Change my password"
    Then I should see "Your settings was saved"

  @javascript
  Scenario: User tries to change their password by inserting a wrong value
    Given I am authenticated as a "bootstrapp" member
    And I am on the "bootstrapp" settings page
    And I fill in "Password" with "123456"
    And I fill in "Password confirmation" with "12345"
    And I press "Change my password"
    Then I should see "There was some errors preventing your settings to being saved."
