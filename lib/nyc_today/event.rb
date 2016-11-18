class NycToday::Event
  attr_accessor :name, :venue, :time, :price_or_age, :ticket_url, :event_link

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


end
