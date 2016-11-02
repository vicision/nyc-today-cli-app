# Our CLI Controller

class NycToday::CLI

  def call
    puts "Today's indie concerts and more in NYC:"
    list_events
    menu
    goodbye
  end

  def list_events
    puts <<-DOC.gsub /^\s*/, ''
      1. First event tonight - First venue name - Event time - Price
      2. Second event tonight - Second venue name - Event time - Price
    DOC
  end

  def menu
    input = nil
    until input == "exit"
      puts "Enter the number of the event for which you'd like more info or type 'list' to see the events again:"
      input = gets.strip.downcase
      if input == "1"
        puts "1. First event tonight - First venue name - Event time - Price"
      elsif input == "2"
        puts "2. Second event tonight - Second venue name - Event time - Price"
      elsif input == "list"
        list_events
      else
        puts "Input not valid: please enter a number from the list above"
      end
    end
  end

  def goodbye
    puts "Good-bye! Come back tomorrow for a new list of events"
  end

end
