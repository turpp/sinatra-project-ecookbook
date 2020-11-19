class AddColumnRecipetypeId < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :recipeType_id, :integer
  end
end
