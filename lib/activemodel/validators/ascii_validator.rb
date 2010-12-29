class AsciiValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value && ! value.ascii_only?
      record.errors[attribute] << "is not an ascii string"
    end
  end
end