Then /^I should see error messages$/ do
  page.body.should match(/error(s)? prohibited/m)
end
