Feature: Routing
  In order to get access to their site
  A user
  Should be able to visit their subdomain

    Scenario: User visits an existing subdomain
      Given A subdomain with "company" tld
      When I go to the "company" subdomain
      Then I should see the "company" login page

    Scenario: User visits an reserved subdomain
      When I go to the "api" subdomain
      Then I go to the homepage

    Scenario: User visits an invalid subdomain
      When I go to the "missing" subdomain
      Then I go to the homepage