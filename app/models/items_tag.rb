class ItemsTag < ApplicationRecord
  belongs_to :tag
  belongs_to :cat

  validates :cat_id, uniqueness: { scope: :tag_id }
end
