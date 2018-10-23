
[![Build Status](https://travis-ci.org/tclaus/keytechkit.gem.svg?branch=master)](https://travis-ci.org/tclaus/keytechkit.gem)


# KeytechKit.gem

This gem provides access to keytech Web API. keytech is the PLM / PDM Software from keytech Software GmbH. This gem is not supported by keytech Software GmbH.
Reference implementation can be found on https://plmweb.de

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'keytechKit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keytechKit


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Test
To start a test, run
    $ bundle exec rspec spec

Test often, let tests fail fast.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tclaus/keytechkit.gem.

* Fork the project
* run 'bundle'
* run 'bundle exec rspec spec' for tests
* make your changes
* make tests
* make a pull request


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
