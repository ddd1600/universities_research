class PressMexicanButton 
  def go
   x = rand(1..20)
   if x == 15
     SwitchIp.new.go
     sleep 10
   else
     puts "not this time"
     puts "move along, senyor"
   end 
  end
  
  alias :press :go
end