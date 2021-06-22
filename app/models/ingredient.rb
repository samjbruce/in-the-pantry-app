class Ingredient < ApplicationRecord

  validates :name, presence: true
  validates :user_id, presence: true
  validates :have, presence: true

  belongs_to :user

end
