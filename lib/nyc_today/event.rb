class NycToday::Event
  attr_accessor :name, :venue, :time, :price_or_age, :ticket_url

  @@all = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def music_events
    music_array = @@all.collect{|e|e.event_type == "music"}
  end

  def comedy_events
    comedy_array = @@all.collect{|e|e.event_type == "comedy"}
  end

  def self.all
    @@all
  end


end
