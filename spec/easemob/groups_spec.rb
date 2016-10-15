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
    it 'get group info' do
      res = Easemob.get_group($easemob_rspec_group_g_id)
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data'][0]['id']).to eq $easemob_rspec_group_g_id
      expect(h1['data'][0]['public']).to be true
      expect(h1['data'][0]['allowinvites']).to be false
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
end
