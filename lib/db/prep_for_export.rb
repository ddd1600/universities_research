class PrepForExport
  def self.go(sef) #takes a class parameter (ActiveRecord::Base)
    sef.columns.each.map { |t| [t.name.to_sym, t.type.to_s] }
  end
end
