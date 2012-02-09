user1 = User.create! :name => 'First User', :email => 'first@example.com',  :password => 'secret', :password_confirmation => 'secret', :username => 'first'
user2 = User.create! :name => 'Other User', :email => 'second@example.com', :password => 'secret', :password_confirmation => 'secret', :username => 'second'

subdomain1 = Subdomain.create! :name => 'foo', :tld => 'foo'
subdomain2 = Subdomain.create! :name => 'bar', :tld => 'bar'

user1.subdomains << subdomain1
user1.save!

user2.subdomains << subdomain2
user2.save!
