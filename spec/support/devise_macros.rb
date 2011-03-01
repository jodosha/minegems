module DeviseMacros
  def login_user
    before(:each) do
      subdomain, user = Factory.create(:subdomain), Factory.create(:user)
      subdomain.users << user
      subdomain.save
      user.confirm!
      request.host = "#{subdomain.tld}.#{$host}"
      request.env['MINEGEMS_SITE'] = { 'name' => subdomain.name, 'tld' => subdomain.tld }
      sign_out :user
      sign_in user
    end
  end
end