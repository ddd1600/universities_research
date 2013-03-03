class RandomBrowser
  
  def get
    browser_types = [:chrome, :firefox]
    Watir::Browser.new browser_types[rand(0..1)]
  end

end