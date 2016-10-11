# Easemob

Easemob is an unofficial easemob IM instant message gem, inspired from [huanxin](https://github.com/RobotJiang/ruby-for-huanxin) a lot.

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

