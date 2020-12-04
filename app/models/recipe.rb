class Recipe < ActiveRecord::Base
belongs_to :user
belongs_to :recipe_type
end