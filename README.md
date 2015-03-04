# HumanDateRange

Парсер человеческих дат для русского языка.
Только даты и диапазоны дат. Без времени.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'human_date_range'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install human_date_range

## Usage

```ruby
  HumanDateRange.parse("с 31 декабря по 1 января")
  # ["31-12-2014", "01-01-2015"]
```

## Contributing

1. Fork it ( https://github.com/ablebeam/human_date_range/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
