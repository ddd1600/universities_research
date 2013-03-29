class ModifyUniversityRecords

  def add_enrollment_slopes
    University.all.each do |u|
      x = MathHelper.get_slope_of_linear_regr(u.enrollments, :full_time_students)
      u.full_time_students_slope = x unless x.nan?
      y = MathHelper.get_slope_of_linear_regr(u.enrollments, :part_time_students)
      u.part_time_students_slope = y unless y.nan?
      z = MathHelper.get_slope_of_linear_regr(u.enrollments, :total_students)
      u.total_students_slope = z unless z.nan?
      a = MathHelper.get_slope_of_linear_regr(u.freshman_stats, :freshmen_entering)
      u.entering_freshmen_slope = a unless a.nan?
      b = MathHelper.get_slope_of_linear_regr(u.freshman_stats, :total_entering_undergrads)
      u.total_entering_undergrads = b unless b.nan?
      u.save
      ap u
    end
  end
  
  def add_state_local_funding_etc
    foreign_names = ["state_approp_pctg_core", "local_govt_approp_pctg", "freshmen_entering"]
    local_names   = ["revenues_pctg_state_funding_2011", "revenues_pctg_substate_funding_2011", "freshmen_entering_latest_available"]
    University.all.each do |u|
      r = u.core_revenues.last
      f = u.freshman_stats.last
      u.revenues_pctg_state_funding_2011 = r.state_approp_pctg_core
      u.revenues_pctg_substate_funding_2011 = r.local_govt_approp_pctg
      u.freshmen_entering_latest_available = f.freshmen_entering
      u.save
    end
  end
  
  def get_snobs_state_local_funding_etc
    University.where(:revenues_pctg_state_funding_2011 => nil).each do |u|
      pctg_state = u.core_revenues.each.map(&:state_approp_pctg_core).compact.last
      pctg_local = u.core_revenues.each.map(&:local_govt_approp_pctg).compact.last
      new_freshmen= u.freshman_stats.each.map(&:freshmen_entering).compact.last
      u.revenues_pctg_state_funding_2011 = pctg_state
      u.revenues_pctg_substate_funding_2011 = pctg_local
      u.freshmen_entering_latest_available = new_freshmen
      u.save
    end
  end
  
  def get_supply_slope_data #the 'supply slope' is a line which, the more downward (negative) it slopes, the more "supply strain" (demand) there is on the private sector for college housing, or at least thats the hypothesis
    University.all.each do |u|
      begin
      rbs = u.room_and_boards
      x = ::MathHelper.get_linear_regression_formula(rbs, :supply_minus_demand)[0].round(1)
      u.supply_slope_all_undergrads = x unless x == (0.0/0.0)
      y = ::MathHelper.get_linear_regression_formula(rbs, :supply_minus_demand_f)[0].round(1)
      u.supply_slope_entering_freshmen = y unless y == (0.0/0.0)
      u.save
    rescue NoMethodError
      next
    rescue ActiveRecord::StatementInvalid; next; rescue TypeError; next
      end
    end
  end
  
end