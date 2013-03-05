class AddLatestEndowmentNumberColumnToUniversities < ActiveRecord::Migration
  def change
    add_column :universities, :latest_endowment_number, :integer
  end
end
