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
  end

  def self.reformat_types #should this be moved to the scraper? IOW, should each event type be reformatted as it's created? Possibly!
    @@all.collect! do |event|
      if event.event_type.include?("Dj")
        words = event.event_type.split(" ")
        words[0].upcase!
        words.join(" ")
      elsif event.event_type.include?("Food")
        event.event_type.insert(4, ",").insert(10, " &")
      elsif event.event_type.include?("Talks")
        event.event_type.split(" ").join(" & ")
      elsif event.event_type.include?("Theatre")
        event.event_type.insert(7, " &")
      else
        event.event_type
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
