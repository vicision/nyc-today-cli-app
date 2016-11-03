class NycToday::Event
  attr_accessor :name, :venue, :time, :price, :ticket_url

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
