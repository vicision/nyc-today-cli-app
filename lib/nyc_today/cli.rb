# Our CLI Controller

class NycToday::CLI

  def call
    welcome
    list_events
    goodbye
  end

  def welcome
    puts
    puts "Welcome to NYC Today, your guide to today's"
    puts "indie concerts and other events in the New York Metro Area."
    puts
    puts "Here are today's events by time:"
    puts
  end

  def more_info
    puts "Enter an event number for more information"
  end

  def list_events
    NycToday::Scraper.scrape_events
    NycToday::Event.all.sort_by!{|e|e.time_stamp}
    NycToday::Event.all[1..10].each.with_index(1) do |event, i|
      puts "#{i.to_s.rjust(3," ")} | #{event.name}"
      puts "    | #{event.time} at #{event.venue}"
      puts
    end
    puts "Enter the number of any event you'd like to know more about or type 'more' for the next 10 events."
    puts
  end

  def menu
    input = nil
    until input == "exit"
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
