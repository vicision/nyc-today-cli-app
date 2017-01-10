class NycToday::Event
  attr_accessor :name, :venue, :time, :time_stamp, :event_link, :event_info, :event_type, :price

  @@all = []
  @@sorted_sets = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end

  def self.sorted_sets
  #   @@sorted_sets = []
  #   @@all.collect do |event|
  #
    @@all.sort_by!{|e|e.event_type.length}
  #   @@sorted_sets.group_by{|e|e.event_type}.each{|type, events|events.sort_by!{|e|e.time_stamp}}
  #   # @@sorted_sets.collect{|type, events|events.to_a.each_slice(9).to_a}
  #   # @@sorted_sets.each{}shift
  #   # @@sorted_sets
  #   # @@sorted_sets.each do |set|
  #   #   set.sort_by!{|e|e.time_stamp}.each_slice(10).to_a
  #   # end
  end

  def reset
    all.clear!
  end

  def self.event_types
    all.collect{|event|event.event_type}.uniq!
  end

  def self.reformat_types
    all.each do |event|
      if event.event_type.include?("Dj")
        event.event_type.sub!("j", "J")
      elsif event.event_type.include?("Food")
        event.event_type.insert(4, ",").insert(10, " &")
      elsif event.event_type.include?("Talks")
        event.event_type = event.event_type.insert(8, " &")
      elsif event.event_type.include?("Theatre")
        event.event_type.insert(7, " &")
      else
        event.event_type
      end
    end
  end

  def event_sets(input)
    choice = event_types[input]
    event_group = []
    all.each do |event|
      if event.event_type.downcase == choice.downcase
        event_group << event
      end
    end
    event_sets = event_group.sort_by!{|e|e.time_stamp}.each_slice(9).to_a
  end

  def self.list_events_by_type(type)
    @@all.each do |event|
      if event.event_type == type
        puts event.name
        puts event.venue
      end
    end
  end


end
