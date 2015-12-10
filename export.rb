require 'open-uri'
require 'yaml'
require 'json'
require 'active_support/all'


# helpers
def to_date(date)
  date.strftime('%Y-%m-%d')
end

def url(item)
  item['url'] || "https://en.wikipedia.org/wiki/#{URI::encode(item['wikipedia'])}"
end

apps = YAML.load_file('db/apps.yml')

# items
items = apps.flat_map.with_index do |item, i|
  item['events'].flat_map.with_index do |event, ei|
      events = [{
        id: "#{i + 1}-#{ei + 1}",
        group: i + 1,
        title: event['title'] || item['title'],
        start: event['start'],
        end: event['end'] || to_date(Time.now),
        eventType: event['type'],
        className: event['type'],
        url: url(item),
        displayTitle: ei == 0 ? true : false
      }]

    if !event['end'] and (ei + 1) == item['events'].length
      events << {
        id: "#{i + 1}-#{item['events'].length + 1}",
        group: i + 1,
        title: event['title'] || item['title'],
        start: to_date(Time.now),
        end: to_date(Time.now + 12.months),
        eventType: event['type'],
        className: (event['type']) + ' fading',
        url: url(item),
      }
    end

    if event['end'] and !event['type'] and (ei + 1) == item['events'].length
      events << {
        id: "#{i + 1}-#{item['events'].length + 1}",
        group: i + 1,
        title: event['title'] || 'Discontinued',
        start: event['end'],
        end: event['end'].to_date + 1.month,
        eventType: 'discontinued',
        className: 'discontinued',
      }
    end

    events
  end
end

# groups
groups = apps.map.with_index { |item, i|
  {
    id: i + 1,
    url: url(item),
    start: item['events'][0]['start'],
    className: item['platforms'].map{|p| p['name'] }.join(' ')
  }
}

# background items
YAML.load_file('db/events.yml').each do |event|
  items << {
    content: event['title'],
    start: event['start'],
    end: event['end'],
    eventType: 'background',
    type: 'background',
  }
end

# Export
File.write('assets/javascripts/items.js', "var items = #{JSON.dump(items)};")
File.write('assets/javascripts/groups.js', "var groups = #{JSON.dump(groups)};")
