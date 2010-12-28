module RSpec
  module ActiveRecord
    module Attributes
      def accessible_attributes
        self.class.accessible_attributes.to_a.map(&:to_sym)
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include RSpec::ActiveRecord::Attributes
end