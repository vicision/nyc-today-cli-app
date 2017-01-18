class NycToday::CLI

  @@set_no = 0
  @@type_choice = 0

  def call
    welcome
    NycToday::Scraper.scrape_events
    list_event_types
  end

  def welcome
    system "clear"
    puts "Welcome to NYC Today, your guide to live music"
    puts "and other events in and around New York City today!"
    puts
    puts "Please wait a few seconds while I gather today's events."
    puts "For best results, maximize the terminal."
    system "clear"
  end

  def list_event_types
    puts "Here are today's event categories:"
    puts
    type_entry
    puts
    puts "-------------------------------------------------------------"
    puts "* Enter a number for the type of event you would like to see."
    puts "* Type 'exit' to leave the program."
    choose_type
    list_events
  end

  def type_entry
    NycToday::Event.event_types.each.with_index(1) do |event_type, i|
      puts "#{i.to_s.rjust(2," ")} | #{event_type}"
    end
  end

  def choose_type
    input = gets.strip
    if input.to_i > 0 && input.to_i <= NycToday::Event.event_types.count
      @@type_choice = input.to_i-1
    elsif input.downcase == "exit"
      goodbye
    else
      system "clear"
      puts "I'm sorry, that is not an option. Please choose a number from the menu."
      sleep 1
      system "clear"
      list_event_types
    end
  end

  def list_events
    system "clear"
    page_count
    category
    if @@set_no+1 <= page_count
      puts "Here's page #{@@set_no+1}/#{page_count} of today's #{category} events ordered by time:"
      puts
      event_entry
    else
      end_of_list
    end
    selection
  end

  def page_count
    NycToday::Event.event_sets(@@type_choice).count
  end

  def category
    NycToday::Event.event_types[@@type_choice]
  end

  def event_entry
    NycToday::Event.event_sets(@@type_choice)[@@set_no].each.with_index(1) do |event, i|
      puts "#{i.to_s.rjust(3," ")} | #{event.name}"
      puts "    | #{event.time} at #{event.venue}"
      puts
    end
  end

  def error
    puts "I'm sorry, I didn't understand what you typed. Please try again."
    sleep 1
    system "clear"
  end

  def selection
    more_events
    input = gets.strip.downcase
    if input == "" or input == " "
      @@set_no += 1
      system "clear"
      list_events
    elsif input.to_i > 0
      event = NycToday::Event.sets[@@set_no][input.to_i-1]
      NycToday::Scraper.scrape_event_page(event) unless event.event_info != nil
      more_info(event)
    elsif input == "menu"
      reset_menu
    elsif input == "back"
      @@set_no -= 1
      list_events
    elsif input == "exit"
      goodbye
    else
      system "clear"
      error
      sleep 2
      list_events
    end
  end

  def more_events
    puts "--------------------------------------------------------------"
    puts "* Enter the number of any event you'd like to know more about."
    puts "* Press Enter for more events"
    puts "* Type 'menu' to return to the main menu, or type 'back' or 'exit'."
  end

  def more_info(event)
    if event.event_info != nil || event.price != nil
      system "clear"
      puts "--------------------------------------------------------------"
      puts "Ticket info: #{event.price}\n" + "\n" unless event.price == nil
      puts wrap(event.event_info, 80) unless event.event_info == nil
    else
      system "clear"
      puts "I'm sorry, there is no additional information about this event."
    end
    return_to_menu
  end

  def return_to_menu
    puts
    puts "--------------------------------------------"
    puts "* Press Enter to return to the list of events."
    puts "* Type 'exit' to leave the program."
    input = gets.strip.downcase
    if input == "exit"
      goodbye
    else
      system "clear"
      list_events
    end
  end

  def end_of_list
    puts "You've reached the end of the #{category} events list. Would you like to see it again? (Y/n)"
    input = gets.strip.downcase
    if input == "y"
      @@set_no = 0
      list_events
    elsif input == "n"
      puts
      puts "Returning to main menu..."
      sleep 1
      reset_menu
    else
      error
      end_of_list
    end
  end

  def reset_menu
    system "clear"
    NycToday::Event.reset_sets
    @@set_no = 0
    @@type_choice = 0
    list_event_types
  end

  def goodbye
    system "clear"
    puts "Good-bye! Come back tomorrow for a new list of events."
    sleep 1.25
    system "clear"
    exit
  end

  def wrap(text, width=80)
    paragraphs = text.split("\n")
    wrapped = paragraphs.collect do |para|
  	  para.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
    end
    wrapped
  end

end
