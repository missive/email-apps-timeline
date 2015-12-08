require 'open-uri'
require 'json'

data = JSON.parse File.read('data.json')

# items
items = data.flat_map.with_index do |item, i|
  item['events'].map.with_index do |event, ei|
    {
      id: "#{i + 1}-#{ei + 1}",
      group: i + 1,
      title: item['title'],
      start: event['start'],
      end: event['end'] || Time.now,
      eventType: event['type'] || 'generic',
      className: event['type'] || 'generic',
      buyer: event['buyer'],
      price: event['price'],
    }
  end
end

# groups
groups = data.map.with_index { |item, i|
  {
    id: i + 1,
    url: item['url'] || "https://en.wikipedia.org/wiki/#{URI::encode(item['wikipedia'])}",
    content: item['title'],
    start: item['events'][0]['start'],
  }
}

# Export
File.write('items.js', "var items = #{JSON.dump(items)};")
File.write('groups.js', "var groups = #{JSON.dump(groups)};")
