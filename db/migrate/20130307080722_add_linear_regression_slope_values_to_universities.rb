class AddLinearRegressionSlopeValuesToUniversities < ActiveRecord::Migration
  def change
    add_column :universities, :supply_slope_all_undergrads, :float
    add_column :universities, :supply_slope_entering_freshmen, :float
  end
end
