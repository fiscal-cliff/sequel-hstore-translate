# Sequel::Hstore::Translate

This gem is port of https://github.com/Leadformance/hstore_translate adapted for sequel.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-hstore-translate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-hstore-translate

## Usage

Suppose you have following table

```ruby
DB.create_table(:test_mods, temp: true) do
  primary_key :id
  column :text_translations, 'public.hstore'
end
```

Then you should use the plugin this way:

```ruby
class TestMod < Sequel::Model
  plugin :hstore_translate, :text # one or an array of columns with translations
end
```

At the moment translations fallback functionality hadn't been implemented.

## Development

Pending...

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fiscal-cliff/sequel-hstore-translate.
