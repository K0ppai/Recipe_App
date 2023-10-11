class AddFoodcounterToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :foodcounter, :integer, default: 0
  end
end
