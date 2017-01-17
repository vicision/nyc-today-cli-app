class NycToday::Scraper

  @@main_url = "http://nyc-shows.brooklynvegan.com"
  @@pages = []

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
        if event.css(".ds-byline").text != ""
          event_hash[:name] = event.css(".ds-byline").text.lstrip + " " + event.css(".ds-listing-event-title-text").text.lstrip
        else
          event_hash[:name] = event.css(".ds-listing-event-title-text").text.lstrip
        end
        event_hash[:venue] = event.css(".ds-venue-name").text.gsub!(/\s+/, " ").strip
        event_hash[:time] = event.css(".dtstart").text.gsub!(/\s+/, " ").strip
        event_hash[:time_stamp] = Time.parse(event_hash[:time])
        event_hash[:event_link] = @@main_url + url_end
        event_hash[:event_type] = event.attr("class").sub!("ds-listing event-card ds-event-category-", "").split("-").map(&:capitalize).join(" ")
        NycToday::Event.new(event_hash)
      end
    end
    NycToday::Event.reformat_types
  end

  def self.scrape_event_page(event)
    event_page = Nokogiri::HTML(open(event.event_link))
    event.price = event_page.css(".ds-ticket-info").text.strip.gsub!(/\s+/, " ")
    if event_page.at(".ds-event-description-inner")
      event.event_info = event_page.css(".ds-event-description-inner").text.strip.gsub!(/$/, "\n").to_s
    else
      event.event_info = nil
    end
  end

end
