require 'csv'

class ExtractStatsFromCsvs
  
  attr_reader :flawed
  
  def initialize
    @coords = Utility.get_coords
    @flawed = []
    Dir.chdir(File.join(Rails.root, 'lib', 'cleaned')) {
      @filenames = Dir.glob("*") }
    @already = Yearly.all.each.map  { |t| t.symbol }.uniq
  end
  
  def get_all_ratios
    @filenames.each do |filename|
      next if @already.include?(filename.split(" ").first)
      f = File.open(File.join(Rails.root, 'lib', 'cleaned', filename))
      a = CSV.read(f)
      i = 1
      10.times do
          y = Yearly.new
          y.symbol = filename.split(" ").first
          puts "\n\n#{y.symbol}\n\n"
          date = a[1][i].split('-')
          y.year = date[0]
          y.month = date[1]
          @coords.each do |c|
            begin
            target = a[c[1]][i]
            eval("y.#{c[0]} = clean_string(target)") #this is quite the piece of work. I'm not very proud of it.
            rescue NoMethodError
              next
            end
          end
          
          y.save
          ap y
        i += 1
      end
    end
  end
  
  def get_price
    begin
      #g = GetSingleHistoricalPrice.new
      d = Date.new(f.year, f.month, 1)
      g.go(f.symbol, d.to_s)
    rescue NoMethodError
      return nil
    end
  end

  def clean_string(string) #removes commas
    return nil if string.nil?
    string.gsub(",", "") unless string.nil?
  end
  
end
