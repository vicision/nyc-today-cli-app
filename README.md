# NYC Today

NYC Today is a Ruby Gem that provides a CLI for navigating events from [Brooklyn Vegan's event listings](http://nyc-shows.brooklynvegan.com/), allowing users to select an event category, browse a list of events and details in that category, and view more information about a chosen event.

## Installation

> * This gem requires Ruby version 2.3.0 or higher

Add this line to your application's Gemfile:

```ruby
gem 'nyc_today'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nyc_today

## Usage

To use NYC Today after installing, type `nyc-today` in the command line and follow the on-screen prompts when the gem launches.

If you're having trouble launching the gem, try entering `gem install bundler` to update your Bundler installation.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vicision/nyc-today-cli-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
