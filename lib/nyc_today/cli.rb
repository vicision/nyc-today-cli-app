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
    puts
    puts "Welcome to NYC Today, your guide to live music
and other events in and around New York City today."
    puts
    puts "** Maximize terminal for best experience. **"
    puts
    puts "Please wait while I gather all of today's events.
This may take a few seconds..."
    puts
  end

  def list_event_types
    puts "Here are today's event categories:"
    puts
    NycToday::Event.event_types.each.with_index(1) do |event_type, i|
      puts "#{i.to_s.rjust(2," ")} | #{event_type}"
    end
    puts
    puts "What type of events would you like to see? Please enter a number from the menu above."
    @@type_choice = gets.strip.to_i-1
  end


  def list_events
    puts "Here's set #{@@set_no+1} of today's #{NycToday::Event.event_types[@@type_choice]} events ordered by time:"
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
        event_choice = NycToday::Event.sets[@@set_no][input.to_i-1]
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

  def more_info(event_choice)
    NycToday::Scraper.scrape_event_page(event_choice)
    if event_choice.event_info != " " && event_choice.event_info != nil && event_choice.event_info != ""
      puts event_choice.price
      puts
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
    system "clear"
    puts
    puts "Good-bye! Come back tomorrow for a new list of events."
    exit
  end


  def end_of_list
    puts "You've reached the end of the list for this type of event. Would you like to see them again? (Y/n)"
    puts
    input = gets.strip.downcase
    if input == "y"
      @@set = 0
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
