class User < ApplicationRecord
  has_secure_password

  validates :username,
            format: { with: /\A[a-zA-Z0-9]+\z/,
                      message: 'username should only contain alphanumeric characters (A-Z, 0-9)' },
            length: { in: 6..20, wrong_length: 'username should be 6-20 characters long!' },
            uniqueness: { case_sensitive: false, message: 'username is taken!' },
            on: :create
  validates :password,
            length: { in: 6..20, wrong_length: 'password should be 6-20 characters long!' },
            on: :create
end
