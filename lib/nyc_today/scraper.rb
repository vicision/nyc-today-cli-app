
require 'pry'

class NycToday::Scraper

  def self.scrape_events
  # Use nokogiri and open-uri to scrape brooklynvegan's events page to extract properties and instantiate an event
    doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))
    doc.css(".ds-listing").each do |event|
      url_front = "http://nyc-shows.brooklynvegan.com"
      url_back = event.css("a").attribute("href").value
      event_url = url_front + url_back
      event_doc = Nokogiri::HTML(open(event_url))

      event_hash = NycToday::Event.new({
        name: event.css(".ds-listing-event-title-text").text,
        venue: event.css(".ds-venue-name").text.gsub(/\s+/, " "),
        time: event.css(".dtstart").text.gsub(/\s+/, " "),
        price: event_doc.css("h2.ds-ticket-info").text
        })

        # binding.pry
    end

  end

end
