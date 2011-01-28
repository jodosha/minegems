class GemValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.spec.nil?
      record.errors[attribute] << "empty spec"
    end
  end
end