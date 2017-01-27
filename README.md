# NYC Today

NYC Today is a Ruby Gem that provides a CLI for navigating events from [Brooklyn Vegan's event listings](http://nyc-shows.brooklynvegan.com/), allowing users to select an event category, browse a list of events and details in that category, and view more information about a chosen event.

## Installation

**This gem requires Ruby version 2.3.0 or higher**

Add this line to your application's Gemfile:

```ruby
gem 'nyc_today'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nyc_today

## Usage

To use NYC Today after installing, type `nyc_today` in the command line and follow the on-screen prompts when the gem launches.

Getting errors? Add an [issue](https://github.com/vicision/nyc-today-cli-app/issues). If it's one of the following, try the suggestions below:

* If your error looks like this one, try running `gem install bundler` to update your Bundler installation. You may then also need to reinstall the `nyc_today` gem:

  ```
  /Users/your_name/.rvm/rubies/ruby-2.4.0/lib/ruby/site_ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require': cannot load such file -- bundler/setup (LoadError)
      from /Users/your_name/.rvm/rubies/ruby-2.4.0/lib/ruby/site_ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require'
      from /Users/your_name/.rvm/gems/ruby-2.4.0@global/gems/nyc_today-0.1.3/bin/nyc_today:3:in `<top (required)>'
      from /Users/your_name/.rvm/rubies/ruby-2.4.0/bin/nyc_today:22:in `load'
      from /Users/your_name/.rvm/rubies/ruby-2.4.0/bin/nyc_today:22:in `<main>'
      from /Users/your_name/.rvm/gems/ruby-2.4.0@global/bin/ruby_executable_hooks:15:in `eval'
      from /Users/your_name/.rvm/gems/ruby-2.4.0@global/bin/ruby_executable_hooks:15:in `<main>'
  ```


* If your error looks like this one, you need to upgrade Ruby to version 2.3.0 or later:

  ```
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today.rb:5:in `require_relative': /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:14: syntax error, unexpected <<, expecting keyword_end (SyntaxError)
    <<~HEREDOC
      ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:16: syntax error, unexpected tIDENTIFIER, expecting keyword_do or '{' or '('
  ...lcome to NYC Today-- your guide to today's events in and aro...
  ...                               ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:18: syntax error, unexpected tIDENTIFIER, expecting keyword_end
      Please wait a few seconds while I gather today's events.
                                                      ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:20: syntax error, unexpected tIDENTIFIER, expecting keyword_do or '{' or '('
      For the best experience, maximize the terminal.
                                           ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:35: syntax error, unexpected <<
    <<~HEREDOC
      ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:38: syntax error, unexpected *
      * Enter a number for the type of event you would like to see.
       ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:38: syntax error, unexpected tIDENTIFIER, expecting keyword_do or '{' or '('
      * Enter a number for the type of event you would like to see.
                                   ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:39: syntax error, unexpected tIDENTIFIER, expecting keyword_end
      * Type 'exit' to leave the program.
                      ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:129: syntax error, unexpected <<
    <<~HEREDOC
      ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:131: syntax error, unexpected *
      * Enter the number of any event you'd like to know more about
       ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:133: syntax error, unexpected tIDENTIFIER, expecting keyword_end
      * Enter 'menu' to return to the main menu
                   ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:134: syntax error, unexpected tIDENTIFIER, expecting keyword_end
      * Enter 'back' to go back or 'exit' to leave the program
                   ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:134: syntax error, unexpected tIDENTIFIER, expecting keyword_end
      * Enter 'back' to go back or 'exit' to leave the program
                                        ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:146: syntax error, unexpected tIDENTIFIER, expecting keyword_end
      puts "\nI'm sorry, there is no additiona...
                 ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:146: syntax error, unexpected tIDENTIFIER, expecting keyword_do or '{' or '('
  ...    puts "\nI'm sorry, there is no additional information ab...
  ...                               ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:146: syntax error, unexpected tSTRING_BEG, expecting '('
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:152: syntax error, unexpected $undefined, expecting keyword_end
    paragraphs = text.split("\n")
                              ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:154: syntax error, unexpected $undefined, expecting keyword_end
      para.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
                                             ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:162: syntax error, unexpected tIDENTIFIER, expecting keyword_end
    if input == "exit"
                     ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:165: syntax error, unexpected tIDENTIFIER, expecting keyword_end
      system "clear"
                   ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:180: syntax error, unexpected $undefined, expecting keyword_end
    puts "\nYou've reached the end of th...
           ^
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:180: unterminated string meets end of file
  /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today/cli.rb:180: syntax error, unexpected end-of-input, expecting keyword_end
    from /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/lib/nyc_today.rb:5:in `<top (required)>'
    from /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/bin/nyc_today:4:in `require_relative'
    from /Library/Ruby/Gems/2.0.0/gems/nyc_today-0.1.2/bin/nyc_today:4:in `<top (required)>'
    from /usr/local/bin/nyc_today:23:in `load'
    from /usr/local/bin/nyc_today:23:in `<main>'
  ```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vicision/nyc-today-cli-app. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
