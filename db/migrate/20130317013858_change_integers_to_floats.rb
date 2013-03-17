class ChangeIntegersToFloats < ActiveRecord::Migration
  def change
    change_column :universities, :total_enrollment_2011, :float
    change_column :universities, :total_enrollment_2003, :float
    change_column :universities, :endowment_2011, :float
    change_column :universities, :endowment_2010, :float
    change_column :universities, :endowment_2009, :float
    change_column :universities, :endowment_2008, :float
    change_column :universities, :endowment_2007, :float
    change_column :universities, :endowment_2006, :float
    change_column :universities, :endowment_2004, :float
    change_column :universities, :endowment_2000, :float
    change_column :universities, :endowment_1996, :float
    change_column :universities, :endowment_1991, :float
    change_column :universities, :endowment_1986, :float
    change_column :universities, :endowment_1980, :float
    change_column :universities, :latest_endowment_number, :float

  end
end
