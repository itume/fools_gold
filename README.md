# FoolsGold


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fools_gold'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fools_gold

## Usage

Install fools_gold, You can use Yen class.
Yen is the currency of Japan.

```
ichi_man_yen = Yen.new(10_000)
```

Yen has methods for calculate consumption tax.
````
ichi_man_yen.with_tax
ichi_man_yen.without_tax
````

Yen instance keeps the state with or without tax.
Default value is "without tax" (Beacause I don't like any tax.)
You can change tax state with "!" methods
```
ichi_man_yen.with_tax?
#=> true

# "!"method changes tax state
ichi_man_yen.without_tax!
ichi_man_yen.with_tax?
#=> false
ichi_man_yen.without_tax?
#=> true

# if state is without_tax and call without_tax!, raise TaxEvationError
ichi_man_yen.without_tax!
#=>TaxEvationError

# if state is with_tax and call with_tax!, raise DoubleTaxaionError
ichi_man_yen.with_tax!
ichi_man_yen.with_tax?
#=> true
ichi_man_yen.with_tax!
#=>DoubleTaxaionError
```

Yen instance has consumption tax rate. This rate uses tax calculation.
Default tax rate is now 8%.
```
ichi_man_yen.tax_rate
#=> 0.08
```

In Oct.1 2019, Japanese government will introduce reduced consumption tax rate.
fools_gold can calculate reduced tax.
```
ichi_man_yen.with_reduced_tax
ichi_man_yen.without_reduced_tax
```
So, from Oct.1 2019, default tax rate changes to 10%.
Reduced tax means set tax rate to 8%.
```
ichi_man_yen.tax_rate
#=> 0.1
ichi_man_yen.reduced_tax_rate
#=> 0.08
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fools_gold. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FoolsGold project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fools_gold/blob/master/CODE_OF_CONDUCT.md).
