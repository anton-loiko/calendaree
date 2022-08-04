class EmailDomainValidator < ActiveModel::Validator
  def validate(record)
    domain = ENV['ALLOWED_EMAIL_DOMAIN']
    puts domain
    record.errors.add :base, "You can only add a user with the domain #{domain}" if record.email.split('@')[1] != domain
  end
end
