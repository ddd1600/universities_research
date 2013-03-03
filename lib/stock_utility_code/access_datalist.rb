class AccessDatalist
  attr_reader :cf, :is, :bs
  def initialize
    @cf = JSON.parse(File.open(File.join(Rails.root, 'lib', 'assets', 'sanitized_header_lists' , 'cf_list.json')).read)
    @is = JSON.parse(File.open(File.join(Rails.root, 'lib', 'assets', 'sanitized_header_lists' , 'is_list.json')).read)
    @bs = JSON.parse(File.open(File.join(Rails.root, 'lib', 'assets', 'sanitized_header_lists' , 'bs_list.json')).read)
  end
end
