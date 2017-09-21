# HacAdapter

HAC Adapter scrapes grades from the interface your school provides (Home Access Center) for keeping track of your kids grades.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hac_adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hac_adapter

## Usage

```ruby
params = {:url=>"URL", :school=>"STRING NAME OF SCHOOL", :username=>"USERNAME", :password=>"PASSWORD"}
puts HacAdapter.all_ascii_reports(params) # For a basic ASCII report
results = HacAdapter.all_reports(params) # For a ruby hash. Useful when consuming the data for a frontend, etc.
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bundle console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hac_adapter.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
