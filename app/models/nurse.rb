class Nurse < ApplicationRecord
  belongs_to :role

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :email, with: VALID_EMAIL_REGEX
end
