require 'byebug'
require 'simplecov'
SimpleCov.start
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'easemob'

load 'spec/test_account.rb'

require 'rspec'
RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://myronmars.to/n/dev-blog/2014/05/notable-changes-in-rspec-3#new__config_option_to_disable_rspeccore_monkey_patching
  config.disable_monkey_patching!

  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  config.warnings = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.before(:suite) do
    res = Easemob.delete_users!
    expect(res.code).to eq 200
    res = Easemob.create_user('u', 'pwd')
    expect(res.code).to eq 200
    users = (1..9).inject([]) { |a, e| a << { username: "u#{e}", password: 'pwd' } }
    res = Easemob.create_users(users)
    expect(res.code).to eq 200
    sleep 1 # must sleep to make sure easemob finish insert.
    res = Easemob.add_user_friend('u', 'u1')
    expect(res.code).to eq 200
    res = Easemob.add_user_friend('u', 'u2')
    expect(res.code).to eq 200
    res = Easemob.add_user_friend('u', 'u3')
    expect(res.code).to eq 200
  end
end
