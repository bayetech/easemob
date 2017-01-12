require 'byebug'
require 'simplecov'
SimpleCov.start
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
    users = (1..10).inject([]) { |a, e| a << { username: "u#{e}", password: 'pwd' } }
    res = Easemob.create_users(users)
    expect(res.code).to eq 200
    res = Easemob.create_users([{ username: 'to_delete_user', password: 'pwd' },
                                { username: 'activated_user', password: 'pwd' },
                                { username: 'deactivated_user', password: 'pwd' }])
    expect(res.code).to eq 200
    sleep 2 # must sleep to make sure easemob finish insert.

    res = Easemob.add_user_friend('u', friend_username: 'u1')
    expect(res.code).to eq 200
    res = Easemob.add_user_friend('u', friend_username: 'u2')
    expect(res.code).to eq 200
    res = Easemob.add_user_friend('u', friend_username: 'u3')
    expect(res.code).to eq 200
    res = Easemob.add_to_user_block 'u', to_block_usernames: %w(u7 u8 u9)
    expect(res.code).to eq 200
    res = Easemob.deactivate_user 'deactivated_user'
    expect(res.code).to eq 200

    # create group
    res = Easemob.create_group 'g', 'group', 'u', members: %w(u1 u2 u3 u4 u5 u10)
    expect(res.code).to eq 200
    h1 = JSON.parse res.body.to_s
    expect(h1['data']['groupid']).not_to be nil
    $easemob_rspec_group_g_id = h1['data']['groupid']
    res = Easemob.create_group 'empty_group', 'empty group', 'u'
    expect(res.code).to eq 200
    h2 = JSON.parse res.body.to_s
    expect(h2['data']['groupid']).not_to be nil
    $easemob_rspec_empty_group_id = h2['data']['groupid']
    res = Easemob.create_group 'to_delete_group', 'to delete group', 'u'
    expect(res.code).to eq 200
    h3 = JSON.parse res.body.to_s
    expect(h3['data']['groupid']).not_to be nil
    $easemob_rspec_to_delete_group_id = h3['data']['groupid']
    res = Easemob.create_group 'newowner_group', 'new owner group', 'u', members: %w(u1)
    expect(res.code).to eq 200
    h4 = JSON.parse res.body.to_s
    expect(h4['data']['groupid']).not_to be nil
    $easemob_rspec_newowner_group_id = h4['data']['groupid']
    res = Easemob.create_group 'to_unblock_group', 'need to unblock group', 'u', members: %w(u1 u2 u3 u4 u5)
    expect(res.code).to eq 200
    h5 = JSON.parse res.body.to_s
    expect(h5['data']['groupid']).not_to be nil
    $easemob_rspec_to_unblock_group_id = h5['data']['groupid']
    res = Easemob.add_to_group_block $easemob_rspec_to_unblock_group_id, to_block_usernames: %w(u3 u4 u5)
    expect(res.code).to eq 200

    # create chatroom
    res = Easemob.create_chatroom 'c', 'chatroom', 'u', members: %w(u1 u2 u3 u4 u5)
    expect(res.code).to eq 200
    h7 = JSON.parse res.body.to_s
    expect(h7['data']['id']).not_to be nil
    $easemob_rspec_chatroom_c_id = h7['data']['id']

    res = Easemob.create_chatroom 'to_delete_chatroom', 'to delete chatroom', 'u'
    expect(res.code).to eq 200
    h9 = JSON.parse res.body.to_s
    expect(h9['data']['id']).not_to be nil
    $easemob_rspec_to_delete_chatroom_id = h9['data']['id']

    # create chatfile
    res = Easemob.upload_chatfile('spec/easemob_logo.png')
    expect(res.code).to eq 200
    h10 = JSON.parse res.body.to_s
    expect(h10['entities'][0]['type']).to eq 'chatfile'
    $easemob_rspec_easemob_logo_uuid = h10['entities'][0]['uuid']
    $easemob_rspec_easemob_logo_share_secret = h10['entities'][0]['share-secret']

    # message_to u
    res = Easemob.message_to 'u', text: 'Greeting!', from: 'u1'
    expect(res.code).to eq 200
    h11 = JSON.parse res.body.to_s
    expect(h11['data']).not_to be nil
    expect(h11['data']['u']).to eq 'success'

    # get just created message id
    res = Easemob.chatmessages(after: Time.now.to_i - 30)
    expect(res.code).to eq 200
    h12 = JSON.parse res.body.to_s
    expect(h12['entities'].count).to be >= 1
    $easemob_rspec_greeting_msg_id = h12['entities'][0]['msg_id']
  end
end
