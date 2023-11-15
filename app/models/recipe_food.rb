class Recipe < ApplicationRecord
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  validates :name, presence: true, length: { maximum: 250 }
  validates :preparation_time, :cooking_time, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :public, inclusion: { in: [true, false] }

  before_validation :set_default_public

  private

  def set_default_public
    self.public = true if public.nil?
  end
end
