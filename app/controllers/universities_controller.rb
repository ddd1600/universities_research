class UniversitiesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    params.merge(:sort => "research_exp_per_person_2011", :direction => "desc") if params.blank? 
    @states = [nil, "AL", "AK", "AZ", "AR", "CA", "MN", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    @universities = University.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 30) unless params[:query]
    @universities = University.where('name LIKE ?', "%#{params[:query]}%").paginate(:page => params[:page], :per_page => 30) if params[:query]
    @universities = University.where(:state => params[:state]).order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 30) if params[:state] and params[:sort] || params[:direction]
  end

  def show
    @university = University.find(params[:id])
    @rb = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:xAxis][:categories] = @university.room_and_boards.each.map {|t| t.year }
      f.series(:name => "Total Dormroom Capacity", :data => @university.room_and_boards.each.map(&:total_dormroom_capacity))
      f.series(:name => "Freshmen Entering", :data => @university.room_and_boards.each.map(&:freshmen_entering))
      f.series(:name => "Total Entering Undergrads", :data => @university.room_and_boards.each.map(&:total_entering_undergrads))
    end
    @exp = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:xAxis][:categories] = @university.core_expenses.each.map {|t| t.year }
       f.series(:name => "Instruction", :data => @university.core_expenses.each.map(&:instruction_exp_per_fte))
      f.series(:name => "Research", :data => @university.core_expenses.each.map(&:research_exp_per_fte))
      f.series(:name => "Public Service", :data => @university.core_expenses.each.map(&:public_service_exp_per_fte))
      f.series(:name => "Academic Support", :data => @university.core_expenses.each.map(&:academic_support_exp_per_fte))
      f.series(:name => "Student Services", :data => @university.core_expenses.each.map(&:student_services_exp_per_fte))
      f.series(:name => "Institutional Support", :data => @university.core_expenses.each.map(&:institutional_support_exp_per_fte))
      f.series(:name => "Other", :data => @university.core_expenses.each.map(&:all_other_core_exp_per_fte))
    end
    @rev = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:xAxis][:categories] = @university.core_revenues.each.map {|t| t.year }
      f.series(:name => "Tuition", :data => @university.core_revenues.each.map(&:tuition_et_al_pctg_core))
      f.series(:name => "State Approps", :data => @university.core_revenues.each.map(&:state_approp_pctg_core))
      f.series(:name => "City Approps", :data => @university.core_revenues.each.map(&:local_govt_approp_pctg))
      f.series(:name => "Federal Approps", :data => @university.core_revenues.each.map(&:federal_approp_pctg))
      f.series(:name => "Private Gifts", :data => @university.core_revenues.each.map(&:private_gifts_pctg_core))
      f.series(:name => "Investment Return", :data => @university.core_revenues.each.map(&:investment_return_pctg_core))
      f.series(:name => "Other", :data => @university.core_revenues.each.map(&:other_rev_pctg_core))
    end
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
  
  def hc_data_series(name, ar_ary)
    
  end
  
  def sort_column
    University.column_names.include?(params[:sort]) ? params[:sort] : "research_exp_per_person_2011"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
