class AddInteresting2011StatsToUniversitiesForSearches < ActiveRecord::Migration
  def change
    add_column :universities, :revenues_pctg_tuition_2011, :integer
    add_column :universities, :revenues_pctg_federal_aid_2011, :integer
    add_column :universities, :revenues_pctg_inv_return_2011, :integer
    add_column :universities, :revenues_pctg_priv_gifts_2011, :integer
    add_column :universities, :revenues_2011, :integer
    [2011, 2010, 2009, 2008, 2007, 2006, 2004, 2000, 1996, 1991, 1986, 1980].each do |year|
      add_column :universities, "endowment_#{year}".to_s, :decimal
    end

  end
end
