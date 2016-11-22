

# @@doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))


class NycToday::Scraper


  @@main_url = "http://nyc-shows.brooklynvegan.com"
  @@pages = []

  def self.get_pages
    num = 1

    while num < 11
      page_url = @@main_url + "/events/today?page=#{num}"
      page = Nokogiri::HTML(open(page_url))
      @@pages << page
      num += 1
    end
  end


  def self.scrape_events
    get_pages
    @@pages.each do |page|
      page.css(".event-card").each do |event|
        url_end = event.css("a").attribute("href").value
        event_hash = {}
        event_hash[:name] = event.css(".ds-listing-event-title-text").text.strip
        event_hash[:venue] = event.css(".ds-venue-name").text.gsub!(/\s+/, " ").strip
        event_hash[:time] = event.css(".dtstart").text.gsub!(/\s+/, " ").strip
        event_hash[:event_link] = @@main_url + url_end
        NycToday::Event.new(event_hash)
      end
    end
  end



end
