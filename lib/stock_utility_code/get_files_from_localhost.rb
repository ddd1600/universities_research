class GetFilesFromLocalhost
  
  def initialize
    @root_url = "http://localhost:3000/sp500s/"
    @numbers = (1..497).to_a
  end
  
  def go
    @numbers.each do |n|
      response = HTTParty.get("#{@root_url}#{n}.json")
      j = JsonHash.new
      j.data = response.body
      j.save!
    end
  end

end
