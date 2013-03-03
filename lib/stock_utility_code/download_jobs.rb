class DownloadJobs

	def initialize(start)
	  47.times do
	  response = HTTParty.get("http://api.angel.co/1/jobs?page=#{start}")
	  parsed = JSON.parse(response.body)
	  File.open(File.join(Rails.root, 'lib', 'assets', 'all_jobs2.json'), "a+") {|f| f.puts(parsed.to_json) }
	  puts "#{start}"
	  start += 1
	 end	
	end
end
