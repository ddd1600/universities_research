class AddNewData
  def self.add_housing_supply_demand_numbers
    RoomAndBoard.all.each do |r|
      begin
        r.supply_minus_demand = r.total_dormroom_capacity - r.total_entering_undergrads
        r.demand_minus_supply = r.total_entering_undergrads - r.total_dormroom_capacity
        r.supply_minus_demand_f = r.total_dormroom_capacity - r.freshmen_entering
        r.demand_minus_supply_f = r.freshmen_entering - r.total_dormroom_capacity
        r.save
      rescue NoMethodError
        next
      rescue TypeError
        next
      end
    end
  end
end
