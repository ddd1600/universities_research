class ModifyUniversityRecords
  
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
  
end