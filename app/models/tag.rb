class Tag < ApplicationRecord
  belongs_to :user

  validates :title,
            uniqueness: { scope: :user_id, message: 'this tag already exists!' },
            length: { minimum: 1, too_short: 'empty tags are not allowed' }
end
