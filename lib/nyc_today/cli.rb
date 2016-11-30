# Our CLI Controller

class NycToday::CLI

  def call
    NycToday::Scraper.scrape_events
    welcome
    list_events
    selection
    goodbye
  end

  def welcome
    puts
    puts "Welcome to NYC Today, your guide to today's"
    puts "indie concerts and other events in the New York Metro Area."
    puts
    puts "Here are today's events (ordered by time):"
    puts
  end

  def more_info
    puts "Enter an event number for more information"
  end


  @@set = 0

  def selection
    input = gets.strip.downcase
    until @@set == NycToday::Event.all.length-1
      if input == "more"
        @@set += 1
        list_events
      elsif input == "exit"
        goodbye

      end
    end
    puts "That's all of today's events. Would you like to see them again?"
  end

  def list_events
    NycToday::Event.all[@@set].each.with_index(1) do |event, i|
      puts "#{i.to_s.rjust(3," ")} | #{event.name}"
      puts "    | #{event.time} at #{event.venue}"
      puts
    end
    puts "Enter the number of any event you'd like to know more about or type 'more' for the next 10 events."
    selection
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
