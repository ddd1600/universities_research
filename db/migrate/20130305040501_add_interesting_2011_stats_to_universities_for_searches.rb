class AddInteresting2011StatsToUniversitiesForSearches < ActiveRecord::Migration
  def change
    add_column :universities, :revenues_pctg_tuition_2011, :integer
    add_column :universities, :revenues_pctg_federal_aid_2011, :integer
    add_column :universities, :revenues_pctg_inv_return_2011, :integer
    add_column :universities, :revenues_pctg_priv_gifts_2011, :integer
    add_column :universities, :revenues_2011, :integer
    add_column :universities, :instruction_exp_person_2011, :integer
    add_column :universities, :research_exp_per_person_2011, :integer
  end
end
