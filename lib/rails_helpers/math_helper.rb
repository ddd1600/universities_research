class MathHelper
  
  def self.get_percent_change_as_string(original, deviant, negative=nil)
    begin
    diff = deviant.to_d - original.to_d
    pctg_change = diff / original.to_d * 100
    pctg_change = pctg_change * -1 if negative == true
    pctg_change = pctg_change.abs if negative == false
    "#{pctg_change.round(2).to_digits}%"
    rescue FloatDomainError; return nil; end
  end
  
  def self.sum(ary)
      ary.compact.inject(0.0) { |result, el| result + el }
  end
  
  def self.avg(ary) 
      MathHelper.sum(ary) / ary.size
  end
  
  def self.get_x1_and_x2(ar_ary, column_name)
    m_and_yint = MathHelper.get_linear_regression_formula(ar_ary, column_name)
    first_yr = ar_ary.first.year; last_yr = ar_ary.last.year
    x1 = MathHelper.get_coordinates_for_x_int(first_yr, m_and_yint[0], m_and_yint[1])
    x2 = MathHelper.get_coordinates_for_x_int(last_yr, m_and_yint[0], m_and_yint[1])
    [x1, x2]
  end
  
  def self.get_slope_of_linear_regr(ar_ary, column_name)
   begin
      data = MathHelper.get_linear_regression_formula(ar_ary, column_name)
      data[0]
   rescue TypeError; return nil; end
  end
  
  def self.get_linear_regression_formula_output(ar_ary, column_name)
    data = MathHelper.get_linear_regression_formula(ar_ary, column_name)
    "y = #{data[0].round(2)}x + #{data[1].round(1)}"
  end
  
  def self.get_linear_regression_formula(ar_ary, column_name)#, for_display = nil)
    x_data = ar_ary.each.map(&:year); column_name = column_name.to_sym
    y_data = ar_ary.each.map(&column_name)
    x_vector = x_data.to_vector(:scale)
    y_vector = y_data.to_vector(:scale)
    ds = { 'x' => x_vector, 'y' => y_vector }.to_dataset
    mlr = Statsample::Regression.multiple(ds, 'y')
    y_int = mlr.constant; m = mlr.coeffs['x']
    [m, y_int]
  end
  
  def self.get_coordinates_for_x_int(x, m, y_int)
    y = x * m + y_int
    [x.round(3), y.round(3)]
  end
  
  def self.prep_as_datapoints(ar_ary, column_name)
    ary_of_arys = []; column_name = column_name.to_s
    ar_ary.each do |a|
      ary_of_arys << [a.year, eval("a.#{column_name}")]
    end
    ary_of_arys
  end
  
end
