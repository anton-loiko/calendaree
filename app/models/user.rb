class User < ApplicationRecord
  # validates :admin
  validates :email, 'valid_email_2/email': true,
                    presence: true,
                    uniqueness: true
  validates_with EmailDomainValidator

  validates :name, length: { minimum: 2 }, allow_blank: true, exclusion: { in: %w[admin superuser] }
  validates :work_time, comparison: { greater_than_or_equal_to: 1, less_than_or_equal_to: 8 }
  validates :remaining_days, numericality: true

  scope :ordered, -> { order(updated_at: :desc) }

  # broadcasts_to ->(_user) { 'users' }, inserts_by: :prepend
  after_create_commit -> { broadcast_prepend_later_to 'users' }
  after_update_commit -> { broadcast_replace_later_to 'users' }
  after_destroy_commit -> { broadcast_remove_to 'users' }
end

# validates :start_date, comparison: { greater_than_or_equal_to: :end_date }
