puts 'SETTING UP EXAMPLE USERS'
user1 = User.create! :name => 'First User', :email => 'user@test.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user1.name
user2 = User.create! :name => 'Other User', :email => 'otheruser@test.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user2.name
puts 'SETTING UP EXAMPLE SUBDOMAINS'
subdomain1 = Subdomain.create! :name => 'foo'
puts 'Created subdomain: ' << subdomain1.name
subdomain2 = Subdomain.create! :name => 'bar'
puts 'Created subdomain: ' << subdomain2.name
user1.subdomain = subdomain1
user1.save
user2.subdomain = subdomain2
user2.save