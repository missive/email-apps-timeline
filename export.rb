require 'open-uri'
require 'yaml'
require 'json'

data = YAML.load_file('data.yml')

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
    start: item['events'][0]['start'],
  }
}

# # background items

items << {
  content: 'SMTP is introduced',
  start: '1980',
  end: '1981',
  eventType: 'background',
  type: 'background',
}

items << {
  content: 'POP3 and IMAP4 are introduced',
  start: '1996',
  end: '1998',
  eventType: 'background',
  type: 'background',
}

items << {
  content: 'INBOX Zero is introduced by Merlin Mann',
  start: '2007',
  end: '2008',
  eventType: 'background',
  type: 'background',
}


# Export
File.write('items.js', "var items = #{JSON.dump(items)};")
File.write('groups.js', "var groups = #{JSON.dump(groups)};")
