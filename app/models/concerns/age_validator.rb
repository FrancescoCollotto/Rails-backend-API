class AgeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    today = Date.today
    min_age = today.prev_year(16)
    age = Date.parse(value.to_s)
    if age > min_age
      record.errors.add(attribute, "Players must be at least 16 years old to enter the club")
    end
  end
end
