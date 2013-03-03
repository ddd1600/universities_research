class SwitchIp
  def initialize
    @x = rand(1..4)
  end
  def go
    if @x == 4
    turn_off
    sleep 10
    turn_on 
    sleep 10
    else
      puts "no senyor he is a good man!"
    end
  end
  
  def turn_on
    `/usr/bin/env osascript <<-EOF
          tell application "System Events"
            tell current location of network preferences
                set VPN to service "VPN (L2TP)" -- your VPN name here
                if exists VPN then connect VPN
        end tell
      end tell
      EOF` 
   end

   def turn_off
    `/usr/bin/env osascript <<-EOF
      tell application "System Events"
        tell current location of network preferences
                set VPN to service "VPN (L2TP)" -- your VPN name here
                if exists VPN then disconnect VPN
        end tell
    end tell
   EOF`
   end

end