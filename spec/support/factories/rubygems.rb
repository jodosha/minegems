def rubygem_params(attributes = {})
  {
    'file' => ::File.open(::File.dirname(__FILE__) + '/gems/test-0.0.0.gem' )
  }.merge(attributes)
end