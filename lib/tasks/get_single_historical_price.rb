require 'open-uri'
 
class GetSingleHistoricalPrice
  def initialize 
    @month_thing = { "1" => "00", "2" => "01", "3" => "02", "4" => "03", "5" => "04", "6" => "05", "7" => "06", "8" => "07", "9" => "08", "10" => "09", "11" => "10", "12" => "11" }
  end
  
  def get_all_day_prices
    Day.where(:already => false).each do |d|
      begin
      puts "trying to get #{d.symbol}'s price on #{d.reference_date}"
      d.close   = go(d.symbol, d.reference_date)
      d.already = true
      d.save!
      rescue NoMethodError
        mark_as_ignore(d) && next
      end
    end
  end
  
  def go(symbol, datestring)
    datestring = datestring.to_date.to_s unless datestring.is_a?(String)
    url        = generate_url(symbol, datestring)
    doc        = Nokogiri::HTML(open(url))
    trs        = doc.search("table > tr")
    data       = trs[20]
    grab_price(data)
  end
  
  def grab_price(x)
    close = x.css('td')[4].text
    puts close
    close
  end
  
  def generate_url(symbol, datestring)
    date                       = Date.parse(datestring)
    hk                         = lambda { |s, a, b, c, d, e, f| "http://finance.yahoo.com/q/hp?s=#{s}&a=#{a}&b=#{b}&c=#{c}&d=#{d}&e=#{e}&f=#{f}&g=d" }
    daterange                  = get_daterange(date)
    first_day_of_quote_request = b = daterange.first
    last_day_of_quote_request  = e = daterange.last
    month_number               = a = d = @month_thing[date.month.to_s]
    year                       = c = f = date.year
    hk[symbol, a, b, c, d, e, f]
  end
  
  def get_daterange(date)
    ary = (date.day-8..date.day-1).to_a
    ary.delete_if {|d| d <= 0}
    ary
  end
  
  def mark_as_ignore(x)
    x.already = true
    x.save
  end
  
end