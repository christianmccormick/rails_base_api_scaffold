# RailsBaseApiScaffold

Generate API controller scaffolds for E7System's Rails Base API. The generator will create a CRUD API controller, create the controller's spec, add its route to `routes.rb`, and create a serializer for its model. Note that a model must exist before the generator can be run. See Usage for more info.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_base_api_scaffold'
```

#### For Rails 5.0+

```ruby
    gem 'rails_base_api_scaffold', :github => 'christianmccormick/rails_base_api_scaffold', :branch => 'rails_5'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_base_api_scaffold

## Usage

Before generating the scaffold you must generate the model using the built-in rails model generator.

```
rails g model friend name:string age:integer
```

After the model has been created, you can run the generator.

```
rails g rails_base_api_scaffold:controller friend
```

That's it! You should now have an API controller, serializer, route, and API controller spec for your model.

## Generators

The following is a list of the currently available generators.

```
controller
serializer
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rails_base_api_scaffold.
