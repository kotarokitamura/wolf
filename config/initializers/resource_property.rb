class ResourceProperty
  class << self
    resource_properties = YAML.load_file File.expand_path(File.dirname(__FILE__)  + "/../resource_properties.yml")
    resource_properties.each do |key,value|
      define_method key do 
        value
      end
    end
  end
end
