class AddTotalvaluecounterToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :totalvaluecounter, :integer, default: 0
  end
end
