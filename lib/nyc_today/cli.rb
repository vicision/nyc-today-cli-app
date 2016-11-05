# Our CLI Controller

class NycToday::CLI

  def call
    # list_events
    # menu
    goodbye
  end

  def welcome
    puts
    puts "Welcome to NYC Today!"
    puts "Your guide to today's indie concerts and other events in the New York Metro Area."
    puts
  end

  def list_events_min
  end

  def list_events
    NycToday::Scraper.scrape_events_page
    @events = NycToday::Event.all
    @events.each.with_index(1) do |event, i|
      puts "#{i}."
      puts "#{event.name}"
      puts "#{event.time} at #{event.venue}"
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
