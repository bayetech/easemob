require 'spec_helper'

RSpec.describe Easemob::Groups do
  describe '#create_group' do
    it 'can create group without any member' do
      res = Easemob.create_group('g1', 'group 1', 'u1')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['groupid']).not_to be nil
    end

    it 'can create group with group members' do
      res = Easemob.create_group 'g2', 'group 2', 'u1', members: %w(u2 u3)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['groupid']).not_to be nil
    end
  end

  describe '#get_group' do
    it 'get group info by given group_id' do
      res = Easemob.get_group($easemob_rspec_group_g_id)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'][0]['id']).to eq $easemob_rspec_group_g_id
      expect(h1['data'][0]['public']).to be true
      expect(h1['data'][0]['allowinvites']).to be false
    end
  end

  describe '#get_groups' do
    it 'get groups info by given Array of group_id' do
      res = Easemob.get_groups [$easemob_rspec_group_g_id, $easemob_rspec_empty_group_id]
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].collect { |d| d['id'] }).to match_array [$easemob_rspec_group_g_id, $easemob_rspec_empty_group_id]
    end
  end

  describe '#query_groups' do
    it 'get all groups' do
      res = Easemob.query_groups
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].count).to be >= 1
    end
  end

  describe '#query_group_users' do
    it 'get all users in a groups' do
      res = Easemob.query_group_users($easemob_rspec_group_g_id)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].count).to be >= 2
    end
  end

  describe '#delete_group' do
    it 'can delete group' do
      res = Easemob.delete_group($easemob_rspec_to_delete_group_id)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['success']).to be true
      expect(h1['data']['groupid']).to eq $easemob_rspec_to_delete_group_id
    end
  end

  describe '#modify_group' do
    it 'can modify group with new groupname and description' do
      res = Easemob.modify_group($easemob_rspec_group_g_id, groupname: 'g', description: 'group 1 after modified')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['groupname']).to be true
      expect(h1['data']['description']).to be true
      expect(h1['data']['maxusers']).to be nil
    end

    it 'can set maxusers to 500' do
      res = Easemob.modify_group($easemob_rspec_group_g_id, maxusers: 500)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['groupname']).to be nil
      expect(h1['data']['description']).to be nil
      expect(h1['data']['maxusers']).to be true
    end
  end

  describe '#user_join_group' do
    it 'A group can add one user' do
      res = Easemob.user_join_group($easemob_rspec_group_g_id, username: 'u4')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['action']).to eq 'add_member'
      expect(h1['data']['result']).to be true
      expect(h1['data']['groupid']).to eq $easemob_rspec_group_g_id
      expect(h1['data']['user']).to eq 'u4'
    end
  end

  describe '#user_leave_group' do
    it 'A group can remove one user' do
      res = Easemob.user_leave_group($easemob_rspec_group_g_id, username: 'u3')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['action']).to eq 'remove_member'
      expect(h1['data']['result']).to be true
      expect(h1['data']['groupid']).to eq $easemob_rspec_group_g_id
      expect(h1['data']['user']).to eq 'u3'
    end
  end

  describe '#group_add_users' do
    it 'Can add multi users to a group' do
      res = Easemob.group_add_users($easemob_rspec_group_g_id, usernames: %w(u5 u6))
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['action']).to eq 'add_member'
      expect(h1['data']['groupid']).to eq $easemob_rspec_group_g_id
      expect(h1['data']['newmembers']).to match_array %w(u5 u6)
    end
  end

  describe '#group_remove_users' do
    it 'Can remove multi users from a group' do
      res = Easemob.group_remove_users($easemob_rspec_group_g_id, usernames: %w(u1 u2))
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].count).to eq 2
    end
  end

  describe '#user_joined_chatgroups' do
    it 'Get a user joined chatgroups list' do
      res = Easemob.user_joined_chatgroups('u')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'].count).to be >= 2
    end
  end

  describe '#group_set_owner' do
    it 'Set a new owner for a group' do
      res = Easemob.group_set_owner($easemob_rspec_empty_group_id, newowner: 'u1')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['newowner']).to be true
    end
  end

  describe '#query_group_blocks' do
    it 'Query group blocks' do
      res = Easemob.query_group_blocks($easemob_rspec_group_g_id)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']).not_to be nil
    end
  end
end
