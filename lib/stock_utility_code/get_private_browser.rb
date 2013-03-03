class GetPrivateBrowser #currently, this shit doesn't work
  def go
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.privatebrowsing.dont_prompt_on_enter'] = true
    profile['browser.privatebrowsing.autostart'] = true
    Watir::Browser.new :firefox, :profile => "profile"
  end
end
