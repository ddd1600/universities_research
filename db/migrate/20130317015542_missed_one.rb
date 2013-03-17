class MissedOne < ActiveRecord::Migration
  def change
    change_column :core_expenses, :core_expenses_usd, :float
    change_column :core_revenues, :core_revenues_usd, :float
  end
end
