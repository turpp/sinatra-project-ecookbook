class AddColumnRecipetypeId < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :recipe_type_id, :integer
  end
end
