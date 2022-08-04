class User < ApplicationRecord
  # validates :admin
  validates :email, 'valid_email_2/email': true,
                    presence: true,
                    uniqueness: true
  validates_with EmailDomainValidator

  validates :name, length: { minimum: 2 }
  validates :work_time, comparison: { greater_than_or_equal_to: 1, less_than_or_equal_to: 8 }

  # scope :ordered, -> { order(id: :desc) }
  scope :ordered, -> { order(updated_at: :desc) }
end
# validates :start_date, comparison: { greater_than_or_equal_to: :end_date }
