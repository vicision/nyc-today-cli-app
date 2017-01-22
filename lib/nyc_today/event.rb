class NycToday::Event
  attr_accessor :name, :venue, :time, :time_stamp, :event_link, :event_info, :event_type, :price

  @@all = []
  @@sets = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end

  def self.sets
    @@sets
  end

  def self.reset_sets
    sets.clear
  end

  def self.event_types
    all.sort_by!{|e|e.event_type.length}.collect{|event|event.event_type}.uniq!
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

  def self.event_sets(input)
    choice = event_types[input]
    event_group = []
    all.each do |event|
      event.event_type.downcase == choice.downcase ? event_group << event : nil
    end
    @@sets = event_group.sort_by!{|e|e.time_stamp}
    sort_events
  end

  def self.midnight_fix
    midnight = []
    @@sets.reject! do |e|
      e.time_stamp.to_s[11].to_i == 0 && e.time_stamp.to_s[12].to_i < 7 ? midnight << e : nil
    end
  end

  def self.sort_events
    midnight_fix.sort_by!{|e|e.time_stamp}
    @@sets = @@sets.push(*midnight_fix).each_slice(5).to_a
  end

end
