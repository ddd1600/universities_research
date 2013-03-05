class ChangeBigIntegersToBigintTypes < ActiveRecord::Migration
  def change
    change_column :core_expenses, :core_expenses_usd, :decimal
    change_column :core_revenues, :core_revenues_usd, :decimal
    [2011, 2010, 2009, 2008, 2007, 2006, 2004, 2000, 1996, 1991, 1986, 1980].each do |year|
      change_column :universities, "endowment_#{year}".to_s, :decimal
    end
    change_column :universities, :latest_endowment_number, :decimal
  end
end
