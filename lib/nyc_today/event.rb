class NycToday::Event
  attr_accessor :name, :venue, :time, :price_or_age, :ticket_url, :event_link, :event_type

  @@all = []
  @@music_array = []
  @@comedy_array = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.music_array
    @@music_array = @@all.collect{|e|e.event_type == "music"}
  end

  def self.comedy_array
    @@comedy_array = @@all.collect{|e|e.event_type == "comedy"}
  end

  def self.all
    @@all
  end


end
