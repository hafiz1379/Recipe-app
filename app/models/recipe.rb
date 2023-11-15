class Recipe < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :foods, join_table: 'recipe_foods'
end
