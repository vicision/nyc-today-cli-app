class NycToday::Events

  def self.today
    # Should return instances of Events
    puts <<-DOC.gsub /^\s*/, ''
      1. First event tonight - First venue name - Event time - Price
      2. Second event tonight - Second venue name - Event time - Price
    DOC
    event_1 = self.new
    event_1.name = "Machine Gun Kelly"
    event_1.venue = "Irving Plaza"
    event_1.time = "7:00 PM"
    event_1.price = "$35"
    event_1.ticket_url = nil

  end

end
