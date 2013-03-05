class AddStragglerIntegerRevenues2011ToDecimalLot < ActiveRecord::Migration
  def change
    change_column :universities, :revenues_2011, :decimal
  end
end
