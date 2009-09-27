require 'rubygems'
require 'eventmachine'

module Screen
  def self.clear
    print "\e[2J\e[f"
  end
end

module Display
  def receive_data data
    Screen.clear
    height = data[5, 4].unpack('v').first
    width  = data[7, 6].unpack('v').first
    
    (height * width).times do |i|
      $stdout << (data[i + 12] == 0 ? "  " : 'XX')
      $stdout << "\n" if i % width == width - 1
    end
  end
end


EM.run {
  EM.open_datagram_socket "127.0.0.1", 2324, Display
}



