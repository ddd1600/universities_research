class RoomAndBoard < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :university
  alias_attribute :supply_minus_demand_f, :dorm_capacity_minus_entering_freshman_class_size
  alias_attribute :demand_minus_supply_f, :entering_freshman_class_minus_dorm_capacity
  alias_attribute :supply_minus_demand, :dorm_capacity_minus_total_entering_undergrads
  alias_attribute :demand_minus_supply, :total_entering_undergrads_minus_dorm_capacity
  
end
