

# @@doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))


class NycToday::Scraper


  @@main_url = "http://nyc-shows.brooklynvegan.com"
  @@pages = []
  # @@event_pages = []

  def self.get_pages
    num = 1
    while num <= 10
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
        event_hash[:time_stamp] = Time.parse(event_hash[:time])
        event_hash[:event_link] = @@main_url + url_end
        NycToday::Event.new(event_hash)
      end
    end
    scrape_event_pages
  end

  # def self.get_event_pages
  #   NycToday::Event.all.flatten.each do |event|
  #     event_page = Nokogiri::HTML(open(event.event_link))
  #     @@event_pages << event_page
  #   end
  # end

  def self.scrape_event_pages
    NycToday::Event.all.each do |event|
      event_page_url = event.event_link
      event_page = Nokogiri::HTML(open(event_page_url))
      event.event_info = event_page.css(".ds-event-description-inner").text.gsub!(/\s+/, " ")
    end
  end



end
