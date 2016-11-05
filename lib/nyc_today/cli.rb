# Our CLI Controller

class NycToday::CLI

  def call
    list_events
    # menu
    goodbye
  end

  def list_events_min
  end

  def list_events
    puts "Today's indie concerts and more in NYC:"
    NycToday::Scraper.scrape_events
    @events = NycToday::Event.all
    @events.each.with_index(1) do |event, i|
      puts "#{i}."
      puts "#{event.name}"
      puts "#{event.venue}"
      puts "#{event.time}"
      if event.price_or_age != nil
        puts "#{event.price_or_age}"
      end
      puts
    end
  end

  def menu
    input = nil
    until input == "exit"
      puts "Enter the number of the event for which you'd like more info or type 'list' to see the events again:"
      input = gets.strip.downcase
      if input.to_i > 0
        this_event = @events[input.to_i-1]
        puts "#{this_event.name} at #{this_event.venue} - #{this_event.time} - #{this_event.price}"
      elsif input == "list"
        list_events
      elsif input == "exit"
        goodbye
        exit
      else
        puts "Input not valid: please enter a number from the list above"
      end
    end
  end

  def goodbye
    puts "Good-bye! Come back tomorrow for a new list of events"
  end

end
