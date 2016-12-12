class NycToday::Event
  attr_accessor :name, :venue, :time, :time_stamp, :event_link, :event_info

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

  def self.all_sets_sorted
    @@sorted_sets = @@all.sort_by!{|e|e.time_stamp}.each_slice(10).to_a
    @@sorted_sets
  end

  def reset
    @all.clear!
  end


end
