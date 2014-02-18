# Cha

A Ruby wrapper for the ChatWork API

## Installation

Add this line to your application's Gemfile:

    gem 'cha'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cha

## Usage

```ruby
client = Cha.new(api_token: 'YOUR_API_TOKEN')

# Get own information
me = client.me
puts me.chatwork_id
# => "mitukiii"

# Get my tasks
tasks = client.my_tasks
puts tasks.map(&:body)
# => ["掃除", "洗濯"]

# Get my status
puts client.my_status
#=> {"unread_room_num"=>0, "mention_room_num"=>0, "mytask_room_num"=>1, "unread_num"=>0, "mention_num"=>0, "mytask_num"=>2}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2014 [Kazuya Takeshima](mailto:mail@mitukiii.jp). See [LICENSE][license] for details.

[license]: LICENSE.md
