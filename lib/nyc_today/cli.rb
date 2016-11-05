# Our CLI Controller

class NycToday::CLI

  def call
    # welcome
    # menu
    list_events
    goodbye
  end

  def welcome
    puts
    puts "Welcome to NYC Today!"
    puts "Your guide to today's indie concerts and other events in the New York Metro Area."
    puts
    puts "What type of events would you like to see?"
    puts
    options
    selection
  end

  def options
    puts"  1. Music
  2. Comedy
  3. Show me everything!"
  end


  def selection
    input = gets.strip.to_i
    if input == 1
      puts
    elsif input == 2
      puts
    elsif input == 3
      puts
    else
      puts "Sorry, that's not one of the selections. Please choose from option 1-3."
    end

  end

=begin
What type of events would you like to see?
  1. Music
  2. Comedy
  3. Show me everything!

=end


  def list_events_min
  end

  def list_events
    NycToday::Scraper.scrape_events
    @events = NycToday::Event.all
    @events.each.with_index(1) do |event, i|
      puts "#{i}."
      puts "#{event.name}"
      puts "#{event.time} at #{event.venue}"
      puts "#{event.price_or_age}"
      puts
    end
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
