class AddTotalvalueToRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_foods, :totalvalue, :integer, default: 0
  end
end
