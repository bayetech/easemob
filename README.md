![Easemob Logo](https://raw.githubusercontent.com/bayetech/easemob/master/spec/easemob_logo.png)

easemob [![Gem Version][version-badge]][rubygems] [![Build Status][travis-badge]][travis] [![Code Climate][codeclimate-badge]][codeclimate] [![Code Coverage][codecoverage-badge]][codecoverage]
=======

An unofficial [Easemob IM instant message service](http://www.easemob.com/product/im) integration gem, inspired from [huanxin](https://github.com/RobotJiang/ruby-for-huanxin) a lot.

`easemob` gem provide [ALL the RESTful API in server side integration](http://docs.easemob.com/im/100serverintegration/10intro).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easemob'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easemob

## Usage

### Config

Create `config/initializers/easemob.rb` and put following configurations into it.

```ruby
Easemob.client_id     = 'app_client_id'     # 使用 APP 的 client_id
Easemob.client_secret = 'app_client_secret'
Easemob.org_name = 'bayetech' # 企业的唯一标识，开发者管理后台注册账号时填写的企业 ID
Easemob.app_name = 'landlord' # 同一“企业”下“APP”唯一标识，创建应用时填写的“应用名称”
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bayetech/easemob. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).



[version-badge]: https://badge.fury.io/rb/easemob.svg
[rubygems]: https://rubygems.org/gems/easemob
[travis-badge]: https://travis-ci.org/bayetech/easemob.svg
[travis]: https://travis-ci.org/bayetech/easemob
[codeclimate-badge]: https://codeclimate.com/github/bayetech/easemob/badges/gpa.svg
[codeclimate]: https://codeclimate.com/github/bayetech/easemob
[codecoverage-badge]: https://codeclimate.com/github/bayetech/easemob/badges/coverage.svg
[codecoverage]: https://codeclimate.com/github/bayetech/easemob/coverage
