class UniversitiesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  before_filter :guide_user_if_new, :only => :index
  
  def index
    params.merge(:sort => "supply_slope_entering_freshmen", :direction => "desc") if params.blank? 
    @states = states
    @universities = University.the_handler(params)
#    @stats_undergrad = University.get_sample_stats(@universities, :supply_slope_all_undergrads) #returns [stdev, mean]
#    @stats_freshman = University.get_sample_stats(@universities, :supply_slope_entering_freshmen) #returns [stdev, mean]
  end

  def show
    @university = University.find(params[:id])
    rbs = @university.room_and_boards
    crs = @university.core_revenues
    ces = @university.core_expenses
    es = @university.enrollments
    @rb = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:xAxis][:categories] = rbs.map {|t| t.year }
      f.series(:name => "Total Dormroom Capacity", :data => rbs.map(&:total_dormroom_capacity))
      f.series(:name => "Freshmen Entering", :data => rbs.map(&:freshmen_entering))
      f.series(:name => "Total Entering Undergrads", :data => rbs.map(&:total_entering_undergrads))
    end
    @exp = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:xAxis][:categories] = ces.map {|t| t.year }
       f.series(:name => "Instruction", :data => ces.map(&:instruction_exp_per_fte))
      f.series(:name => "Research", :data => ces.map(&:research_exp_per_fte))
      f.series(:name => "Public Service", :data => ces.map(&:public_service_exp_per_fte))
      f.series(:name => "Academic Support", :data => ces.map(&:academic_support_exp_per_fte))
      f.series(:name => "Student Services", :data => ces.map(&:student_services_exp_per_fte))
      f.series(:name => "Institutional Support", :data => ces.map(&:institutional_support_exp_per_fte))
      f.series(:name => "Other", :data => ces.map(&:all_other_core_exp_per_fte))
    end
    @rev = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:xAxis][:categories] = crs.map {|t| t.year }
      names = %w{Tuition StateApprops CityApprops FederalApprops PrivateGifts InvestmentReturn Other}
      columns = %w{tuition_et_al_pctg_core state_approp_pctg_core local_govt_approp_pctg federal_approp_pctg private_gifts_pctg_core investment_return_pctg_core other_rev_pctg_core}.map(&:to_sym)
      names.each_with_index do |title, i|
        f.series(:name => title.underscore.humanize, :data => crs.map {|t| t[columns[i]]})
      end
    end
    
    @housing_diff_scatter = LazyHighCharts::HighChart.new('graph') do |f|
      total_dormroom_capacities = rbs.map(&:total_dormroom_capacity)
      supply_minus_demand_f = rbs.map(&:supply_minus_demand_f)
      supply_minus_demand = rbs.map(&:supply_minus_demand)
      x_max = 2011; x_min = 2005; y_max = total_dormroom_capacities.max + 100; y_min = supply_minus_demand.min - 100
      f.xAxis['min'] = x_min; f.xAxis['max'] = x_max; f.yAxis['min'] = y_min; f.yAxis['max'] = y_max
      f.yAxis [ {:title => {:text => "Housing Supply (#/beds)"}} ]
      regr_formula = MathHelper.get_linear_regression_formula_output(rbs, :supply_minus_demand)
      f.series(:type => "column", :name => "Housing Supply", :data => MathHelper.prep_as_datapoints(rbs, :total_dormroom_capacity))
      #f.series(:type => "column", :name => "Full Time Student Enrollment", :data => MathHelper.prep_as_datapoints(es, :full_time_students))
      f.series(:type => "line", :name => "#{MathHelper.get_linear_regression_formula_output(rbs, :supply_minus_demand)} -- linear regression trend (total_entering_undergrads stat)", :data => MathHelper.get_x1_and_x2(rbs, :supply_minus_demand))
      f.series(:type => "line", :name => "#{MathHelper.get_linear_regression_formula_output(rbs, :supply_minus_demand_f)} -- linear regression trend (total_entering_freshment stat)", :data => MathHelper.get_x1_and_x2(rbs, :supply_minus_demand_f))
      #f.series(:type => "line", :name => "#{MathHelper.get_linear_regression_formula_output(es, :full_time_students)} -- linear regression trend (total_entering_freshment stat)", :data => MathHelper.get_x1_and_x2(rbs, :supply_minus_demand_f))
      
      f.series(:type => "spline", :name => "Housing Supply Indicator (dorm_supply - total_entering_undergrads)", :data => MathHelper.prep_as_datapoints(rbs, :supply_minus_demand))
      f.series(:type => "spline", :name => "Housing Supply Indicator (dorm_supply - total_entering_freshmen)", :data => MathHelper.prep_as_datapoints(rbs, :supply_minus_demand_f))
    end
    @sample_stats_f = MathHelper.get_slope_of_linear_regr(rbs, :supply_minus_demand_f)
    @sample_stats = MathHelper.get_slope_of_linear_regr(rbs, :supply_minus_demand)
    @state_stats_f = University.get_slope_stats_for_where(:room_and_boards, :state, @university.state, :supply_minus_demand_f)
    @state_stats = University.get_slope_stats_for_where(:room_and_boards, :state, @university.state, :supply_minus_demand)
    
    e_years = [1980, 1986, 1991, 1996, 2000, 2004, 2006, 2007, 2008, 2009, 2010, 2011]
    @endowments = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:xAxis][:categories] = e_years
      e_data = []
      e_years.each do |year|
        x = eval("@university.endowment_#{year}")
        e_data << x
      end
      f.series(:name => "Endowment Size", :data => e_data)
    end
  end
  
  private
  
  def guide_user_if_new
    unless ["/", "/universities"].include?(request.path)
      params.clear
      params[:sort] = "supply_slope_entering_freshmen"
      params[:asc] = "asc"
    end
  end
  
  
end
