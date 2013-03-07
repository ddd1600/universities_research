class University < ActiveRecord::Base
  # attr_accessible :title, :body
  [:core_expenses, :core_revenues, :freshman_stats, :room_and_boards].each do |x|
    has_many x
  end
  has_many :users, :through => :interests
  
  def self.the_handler(params)
    search(params[:query]).sort(params).check_for_state(params).paginate(:page => params[:page], :per_page => 30)
  end
  
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
  
  def self.sort_column(p)
    University.column_names.include?(p[:sort]) ? p[:sort] : "research_exp_per_person_2011"
  end
  
  def self.sort_direction(p)
    %w[asc desc].include?(p[:direction]) ? p[:direction] : "desc"
  end
  
end
