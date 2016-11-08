# Our CLI Controller

class NycToday::CLI

  def call
    welcome
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
    puts "  1. Music"
    puts "  2. Comedy"
    puts "  3. Show me everything!"
  end


  def selection
    NycToday::Scraper.scrape_events_pg
    input = gets.strip.to_i
    if input == 1
      puts "Here are today's concerts:"
      NycToday::Event.music_array
    elsif input == 2
      puts "Here are today's comedy shows:"
      NycToday::Event.comedy_array
    elsif input == 3
      puts "Here are all of today's events:"
      list_events
    else
      puts "Sorry, that's not one of the options. Please choose 1, 2 or 3."
    end

  end

  def more_info
    puts "Enter an event number for more information"
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
    @events = NycToday::Event.all
    @events.each.with_index(1) do |event, i|
      puts "#{i}."
      puts "#{event.name}"
      puts "#{event.time} at #{event.venue}"
      if event.price_or_age != (nil || "" || " ")
        puts "#{event.price_or_age}"
      end
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
