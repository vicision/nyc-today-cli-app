class NycToday::CLI


  def call
    welcome
    NycToday::Scraper.scrape_events
    NycToday::Event.sorted_sets
    list_event_types
    list_events
  end

  def welcome
    puts
    puts "Welcome to NYC Today, your guide to live music
and other events in and around New York City today."
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
  end


  def list_events
    set_no = 0
    input = gets.strip.to_i-1
    NycToday::Event.list_events_by_type(input)
    # choice = NycToday::Event.event_types[input]
    # event_group = []
    # NycToday::Event.all.each do |event|
    #   if event.event_type.downcase == choice.downcase
    #     event_group << event
    #   end
    # end
    # event_sets = event_group.sort_by!{|e|e.time_stamp}.each_slice(9).to_a
    puts "Here are 10 of today's #{NycToday::Event.event_types[input]} events by time:"
    puts
    event_sets[set_no].each.with_index(1) do |event, i|
      puts "#{i.to_s.rjust(3," ")} | #{event.name}"
      puts "    | #{event.time} at #{event.venue}"
      puts
    end
    more_events
    set_no += 1
    list_events

    #NEXT: NEED TO FIGURE OUT MOVING ON TO NEXT SET

  end



    #
    # NycToday::Event.all[choice]

    # NycToday::Event.all.each.with_index(1) do |event, i|
    #   if event.event_type.downcase == choice
    #     puts "#{i.to_s.rjust(3," ")} | #{event.name}"
    #     puts "    | #{event.time} at #{event.venue}"
    #     if event.price != " " && event.price != "" && event.price != nil
    #       puts "    | #{event.price}"
    #       puts
    #     else
    #       puts
    #     end
    #   end
    # end




    # puts
    # NycToday::Event.sorted_sets[input].each do |key, val|
    #   val.each.with_index(1) do |event, i|
    #     puts "#{i.to_s.rjust(3," ")} | #{event.name}"
    #     puts "    | #{event.time} at #{event.venue}"
    #   end
    # #   if event.price != " " && event.price != "" && event.price != nil
    # #     puts "    | #{event.price}"
    # #     puts
    # #   else
    # #     puts
    # #   end
    # #   # puts "      #{event.event_type}"
    # end
    # # selection

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

  def more_info(event_choice)
    this_event = NycToday::Event.all_sets_sorted[@@set][event_choice]
    if this_event.event_info != " " && this_event.event_info != nil
    #   system "clear"
    #   this_event.event_info.each do |para|
    #     puts para
    #     puts "\n"
    #     puts "\n"
    #   end
      this_event.event_info.each do |para|
        puts para
        puts ""
      end
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
