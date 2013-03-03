require 'csv'

class LoadRawPriceDataFromCsvs
  def initialize
    @filelist = Dir.glob(File.join(Rails.root, 'lib', 'assets', 'price_data', '*'))
  end
  def go
    @filelist.each_with_index do |f, i|
      puts File.basename(f).split(".")[0].upcase
      parsed = CSV.parse(File.open(f))
      p = PriceData.new
      p.symbol = File.basename(f).split(".")[0].upcase
      p.ary_of_arys = parsed
      p.company_id = Company.find_by_symbol(p.symbol)
      p.save
    end
  end
end