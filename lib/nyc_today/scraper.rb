
class NycToday::Scraper

  def self.scrape_events
  # Use nokogiri and open-uri to scrape brooklynvegan's events page to extract properties and instantiate an event
    doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))
    doc.css(".ds-event-category-music").each do |event|
      NycToday::Event.new({
        name: event.css(".ds-listing-event-title-text").text,
        venue: event.css(".ds-venue-name").text.gsub(/\s+/, ""),
        })
        binding.pry
    end

  end

end
