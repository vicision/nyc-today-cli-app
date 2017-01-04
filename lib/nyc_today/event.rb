class NycToday::Event
  attr_accessor :name, :venue, :time, :time_stamp, :event_link, :event_info, :event_type, :price

  @@all = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end

  def self.all_sets_sorted
    @@sorted_sets = @@all.sort_by!{|e|e.time_stamp}.each_slice(10).to_a
  end

  def reset
    @@all.clear!
  end

  def self.event_types
    @@event_types = @@all.collect{|event|event.event_type}.uniq!
    # self.reformat_types
  end

  def self.reformat_types
    @@event_types.collect! do |type|
      if type.include?("Dj")
        words = type.split(" ")
        words[0].upcase!
        words.join(" ")
      elsif type.include?("Food")
        type.insert(4, ",").insert(10, " &")
      elsif type.include?("Talks")
        type.split(" ").join(" & ")
      elsif type.include?("Theatre")
        type.insert(7, " &")
      else
        type
      end
    end
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
