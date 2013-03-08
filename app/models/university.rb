require 'descriptive-statistics'

class University < ActiveRecord::Base
  # attr_accessible :title, :body
  [:core_expenses, :core_revenues, :freshman_stats, :room_and_boards, :enrollments].each do |x|
    has_many x
  end
  has_many :users, :through => :interests
  
  def self.the_handler(params)
    search(params[:query]).sort(params).check_for_state(params).remove_undesirables.paginate(:page => params[:page], :per_page => 30)
  end
  
  def self.remove_undesirables
    where('supply_slope_all_undergrads IS NOT NULL')
  end
  
  def self.sort_column(p)
    University.column_names.include?(p[:sort]) ? p[:sort] : "research_exp_per_person_2011"
  end
  
  def self.sort_direction(p)
    %w[asc desc].include?(p[:direction]) ? p[:direction] : "desc"
  end
  
  def self.get_population_stats(column_symbol, class_if_not_university = nil)
    x = class_if_not_university || University
    data = x.all.map(&:column_symbol).compact
    stdev = DescriptiveStatistics.new(data).standard_deviation.round(3)
    mean = MathHelper.sum(data) / x.count
    [stdev, mean]
  end
  
  def self.get_slope_stats_for_where(nested_model_names, where_what, where_what_is, column_symbol)
    [nested_model_names, where_what, column_symbol].map!(&:to_sym)
    colleges_in_state = University.where(where_what => where_what_is)
    ary_of_arys = colleges_in_state.map(&nested_model_names)
    slopes = ary_of_arys.map do |nested_ary|
      MathHelper.get_slope_of_linear_regr(nested_ary, column_symbol)
    end
    [MathHelper.avg(slopes), slopes]
  end
  
  def self.get_sample_stats(ar_ary, column_symbol)
    data = ar_ary.map(&column_symbol).compact
    stdev = ::DescriptiveStatistics.new(data).standard_deviation.round(3)
    mean = MathHelper.sum(data).round(1) / data.count
    [stdev, mean]
  end
  
  private
  
  def self.check_for_state(params)
    unless params[:state].blank?
      where(:state => [params[:state]])
    else
      scoped
    end
  end
  
  def self.search(search)
    unless search.blank?; where("name LIKE ?", "%#{search}%")
    else scoped; end
  end
  
  def self.sort(params); p = params
    order(sort_column(p) + " " + sort_direction(p))
  end
  
  
  
end
