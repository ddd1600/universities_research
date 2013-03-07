class OutputRecordsToJsonText
  def self.go(active_relation_ary)
    ary = active_relation_ary
    name = ary[0].class.name
    File.open(File.join(Rails.root, 'lib', 'assets', "#{name}.json"), 'w') do |f|
      f.write(ary.to_json)
    end
  end
end
