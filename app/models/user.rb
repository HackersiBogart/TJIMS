class User < ApplicationRecord
  class User < ApplicationRecord
    # Secure password functionality
    has_secure_password
  
    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
  
end
