class NycToday::Event
  attr_accessor :name, :venue, :time, :event_link

  @@all = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all.push(self)
    # @@all.uniq! do |e|
    #   {e[:name], e[:venue], e[:time]}
    # end
  end

  def self.all
    # @@all.uniq! {|e| e.event_link}
    @@all
  end


end
