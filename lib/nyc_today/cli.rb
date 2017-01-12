class NycToday::CLI

  @@set_no = 0
  @@type_choice = 0

  def call
    welcome
    NycToday::Scraper.scrape_events
    # NycToday::Event.sorted
    list_event_types
    list_events
  end

  def welcome
    system "clear"
    puts "Welcome to NYC Today, your guide to live music
and other events in and around New York City today!"
    puts
    puts "Please wait a few seconds while I gather today's events."
    puts "Maximize your terminal for the best experience!"
    puts
  end

  def list_event_types
    system "clear"
    puts "Here are today's event categories:"
    puts
    NycToday::Event.event_types.each.with_index(1) do |event_type, i|
      puts "#{i.to_s.rjust(2," ")} | #{event_type}"
    end
    puts
    puts "What type of events would you like to see? Please enter a number from the menu above or type 'exit' to leave the program."
    input = gets.strip
    if input.to_i > 0
      @@type_choice = input.to_i-1
    elsif input == "exit"
      goodbye
    end
  end


  def list_events
    system "clear"
    page_count = NycToday::Event.event_sets(@@type_choice).count
    category = NycToday::Event.event_types[@@type_choice]
    puts "Here's page #{@@set_no+1}/#{page_count} of today's #{category} events ordered by time:"
    puts
    NycToday::Event.event_sets(@@type_choice)[@@set_no].each.with_index(1) do |event, i|
      puts "#{i.to_s.rjust(3," ")} | #{event.name}"
      puts "    | #{event.time} at #{event.venue}"
      puts
    end
    selection
  end

  def selection
    more_events
    input = gets.strip.downcase
    until @@set_no == NycToday::Event.sets.length-1
      if input == "" or input == " "
        @@set_no += 1
        system "clear"
        list_events
      elsif input.to_i > 0
        system "clear"
        event_choice = NycToday::Event.sets[@@set_no][input.to_i-1]
        more_info(event_choice)
      elsif input == "exit"
        NycToday::Event.reset_sets
        @@set_no = 0
        list_event_types
      elsif input == "back"
        @@set_no -= 1
        list_events
      else
        system "clear"
        puts "I'm sorry, I didn't understand what you typed. Please try again."
        sleep 2
        list_events
      end
    end
    end_of_list
  end

  def more_events
    puts "Enter the number of any event you'd like to know more about."
    puts "Press Enter for more events, return to the main menu by typing 'exit' or go back by typing 'back'."
  end

  def more_info(event_choice)
    NycToday::Scraper.scrape_event_page(event_choice)
    if event_choice.event_info != " " && event_choice.event_info != nil && event_choice.event_info != ""
      system "clear"
      puts "Price: #{event_choice.price}\n" + "\n" unless event_choice.price == nil
      puts event_choice.event_info
    #   system "clear"
    #   this_event.event_info.each do |para|
    #     puts para
    #     puts "\n"
    #     puts "\n"
    #   end
      # event_choice.event_info.each do |para|
      #   puts para
      #   puts ""
      # end
      # puts "#{reformat_wrapped(this_event.event_info, 66)}"
    else
      system "clear"
      puts "I'm sorry, there is no additional information about this event."
    end
    puts "Press Enter to return to the list of events."
    input = gets.strip.downcase
      if input == ""
        system "clear"
        list_events
      end
  end

  def goodbye
    system "clear"
    puts "Good-bye! Come back tomorrow for a new list of events."
    sleep 1.5
    system "clear"
    exit
  end


  def end_of_list
    puts "You've reached the end of the list for this type of event. Would you like to see them again? (Y/n)"
    puts
    input = gets.strip.downcase
    if input == "y"
      @@set_no = 0
      list_events
    elsif input == "n"
      goodbye
    end
  end

  def reformat_wrapped(text, width=78)

    paragraphs = []
    lines = []
	  line = ""


	  # text.split("n/").each do |parag|
    #   paragraphs << ""
    #   paragraphs << parag
    #   paragraphs << ""

      # paragraphs.each do |word|

	  #   if line.size + word.size >= width
	  #     lines << line
	  #     line = word
	  #   elsif line.empty?
	  #    line = word
	  #   else
	  #    line << " " << word
	  #  end
	  #  end
	  #  lines << line if line
	  #  lines.join "\n"
    #end
    # puts paragraphs
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
