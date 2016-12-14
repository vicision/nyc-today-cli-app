# Our CLI Controller

class NycToday::CLI

  @@set = 0

  def call
    welcome
    NycToday::Scraper.scrape_events
    list_events
  end

  def welcome
    puts
    puts "Welcome to NYC Today, your guide to today's"
    puts "indie concerts and other events in the New York Metro Area."
    puts
    puts "Please wait a few seconds while I gather all of today's events (ordered by time)."
    puts
  end

  def list_events
    puts "Here are 10 of today's events:"
    puts
    NycToday::Event.all_sets_sorted[@@set].each.with_index(1) do |event, i|
      puts "#{i.to_s.rjust(3," ")} | #{event.name}"
      puts "    | #{event.time} at #{event.venue}"
      puts
    end
    selection
  end

  def selection
    more_events
    input = gets.strip.downcase
    until @@set == NycToday::Event.all.length-1
      if input == ""
        @@set += 1
        system "clear"
        list_events
      elsif input.to_i > 0
        event_choice = input.to_i-1
        more_info(event_choice)
        # list_events
        # selection
      elsif input == "exit"
        goodbye
      else
        puts "I'm sorry, I didn't understand what you typed. Please try again."
        sleep(2.5)
        list_events
      end
    end
    end_of_list
  end

  def more_events
    puts "Enter the number of any event you'd like to know more about or press Enter for more events."
  end


  def end_of_list
    puts "This is the end of today's list of events. Would you like to see them again? (Y/n)"
    puts
    input = gets.strip.downcase
    if input == "y"
      @@set = 0
      list_events
    elsif input == "n"
      goodbye
    end
  end

  def reformat_wrapped(s, width=78)
	  lines = []
	  line = ""
	  s.split(/\s+/).each do |word|
	    if line.size + word.size >= width
	      lines << line
	      line = word
	    elsif line.empty?
	     line = word
	    else
	     line << " " << word
	   end
	   end
	   lines << line if line
	  return lines.join "\n"
	end

  def more_info(event_choice)
    this_event = NycToday::Event.all_sets_sorted[@@set][event_choice]
    if this_event.event_info != " " && this_event.event_info != nil
      system "clear"
      puts "#{reformat_wrapped(this_event.event_info, 78)}"
    else
      system "clear"
      puts "I'm sorry, there is no additional information about this event."
    end
    puts
    puts "Press Enter to return to the list of events."
    puts
    input = gets.strip.downcase
      if input == ""
        system "clear"
        list_events
      end
  end

  def goodbye
    puts
    puts "Good-bye! Come back tomorrow for a new list of events."
    exit
  end


  # def menu
  #   input = nil
  #   until input == "exit"
  #     input = gets.strip.downcase
  #     if input.to_i > 0
  #       this_event = @events[input.to_i-1]
  #       puts "#{this_event.name} at #{this_event.venue} - #{this_event.time} - #{this_event.price}"
  #     elsif input == "list"
  #       list_events
  #     elsif input == "exit"
  #       goodbye
  #       exit
  #     else
  #       puts "Input not valid: please enter a number from the list above"
  #     end
  #   end
  # end

end
