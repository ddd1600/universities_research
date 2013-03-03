require 'json'

class LoadJsonToDatabase
  def self.go(classname)
    ary = JSON.parse(File.read(File.join(Rails.root, 'lib', 'db', "#{classname}.json")))
    column_names = ary.first.keys
    class_r = classname.constantize
    ary.each do |ar_hash|
      begin
      r = class_r.new
      column_names.each do |name|
        eval("r.#{name} = ar_hash['#{name}']")
      end
      r.save
    rescue NoMethodError
      next
    end
    end
  end
  
end
