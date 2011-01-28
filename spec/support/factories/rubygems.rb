Factory.define :rubygem do |f|
  f.file nil
end

def rubygem_params(attributes = {})
  {
    'file' => rubygem_file('test-0.0.0.gem')
  }.merge(attributes)
end

def rubygem_file(name)
  ::File.open(::File.dirname(__FILE__) + "/gems/#{name}" )
end

def rubygem_with_invalid_spec(options)
   rubygem = Rubygem.new :file => rubygem_file('test-0.0.0.gem')
   options.each do |k,v|
     rubygem.spec.send("#{k}=", v) rescue nil
   end
   rubygem
end