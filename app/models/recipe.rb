class Recipe < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :recipe_foods

  validates :name, presence: true, length: { in: 1..100 }
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :public, inclusion: { in: [true, false] }
  validates :description, presence: true
end
