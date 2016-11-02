class NycToday::Event
  attr_accessor :name, :venue, :time, :price, :ticket_url

  def self.today
    # Should return instances of Events
    event_1 = self.new
    event_1.name = "Machine Gun Kelly"
    event_1.venue = "Irving Plaza"
    event_1.time = "7:00 PM"
    event_1.price = "$35"
    event_1.ticket_url = nil

    [event_1]

  end

end
