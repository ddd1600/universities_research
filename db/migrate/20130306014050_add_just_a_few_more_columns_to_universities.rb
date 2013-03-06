class AddJustAFewMoreColumnsToUniversities < ActiveRecord::Migration
  def change
    add_column :universities, :revenues_pctg_state_funding_2011, :integer
    add_column :universities, :revenues_pctg_substate_funding_2011, :integer
    add_column :universities, :freshmen_entering_latest_available, :integer
  end
end
