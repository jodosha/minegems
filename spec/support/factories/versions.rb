def version_with_invalid_spec(options)
   version = Version.new :file => rubygem_file('test-0.0.0.gem')
   options.each do |k,v|
     version.spec.send("#{k}=", v) rescue nil
   end
   version
end