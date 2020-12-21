class ItemsTag < ApplicationRecord
  belongs_to :tag
  belongs_to :cat
end
