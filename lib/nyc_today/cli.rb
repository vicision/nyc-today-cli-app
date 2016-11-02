# Our CLI Controller

class NycToday::CLI

  def call
    puts "Today's indie concerts and more in NYC:"
    list_events
    menu
  end

  def list_events
    puts <<-DOC.gsub /^\s*/, ''
      1. First event tonight - First venue name - Event time - Price
      2. Second event tonight - Second venue name - Event time - Price
    DOC
  end

  def menu
    puts "Enter the number of the event for which you'd like more info:"
    input = gets.strip.downcase
    if input == "1"
      puts "1. First event tonight - First venue name - Event time - Price"
    elsif input == "2"
      puts "2. Second event tonight - Second venue name - Event time - Price"
    else
      exit
    end
    call
  end

end
