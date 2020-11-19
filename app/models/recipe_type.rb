class RecipeType < ActiveRecord::Base
    has_many :recipes
end