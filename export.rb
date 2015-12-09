require 'open-uri'
require 'yaml'
require 'json'
require 'active_support/all'

data = YAML.load_file('data.yml')

# items
items = data.flat_map.with_index do |item, i|
  item['events'].flat_map.with_index do |event, ei|
      events = [{
        id: "#{i + 1}-#{ei + 1}",
        group: i + 1,
        title: event['title'] || item['title'],
        start: event['start'],
        end: event['end'] || Time.now,
        eventType: event['type'] || 'generic',
        className: event['type'] || 'generic',
      }]

    if !event['end'] and (ei + 1) == item['events'].length
      events << {
        id: "#{i + 1}-#{item['events'].length + 1}",
        group: i + 1,
        start: Time.now,
        end: Time.now + 6.months,
        eventType: event['type'] || 'generic',
        className: (event['type'] || 'generic') + ' fading',
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
  content: 'IMAP2 is introduced',
  start: '1982',
  end: '1983',
  eventType: 'background',
  type: 'background',
}

items << {
  content: 'POP1 is introduced',
  start: '1985',
  end: '1986',
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
