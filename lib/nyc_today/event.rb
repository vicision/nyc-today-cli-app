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

end
