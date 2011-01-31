class GemValidator < ActiveModel::Validator
  cattr_accessor :required_attributes
  self.required_attributes = %w(name version summary require_paths)

  def validate(record)
    gemspec = record.gemspec

    if gemspec.nil?
      record.errors[:gemspec] << "is empty" and return
    end

    self.class.required_attributes.each do |attr|
      value = gemspec.send(attr) rescue nil
      record.errors[:gemspec] << "#{attr} is required" if value.blank?
    end
  end
end