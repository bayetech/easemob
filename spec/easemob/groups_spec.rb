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

  describe '#modify_group' do
    it 'can modify group with new name and description' do
      res = Easemob.modify_group($easemob_rspec_group_g_id, 'g', 'group 1 after modified')
      expect(res.code).to eq 200
      h1 = JSON.parse res.to_s
      expect(h1['data']['groupname']).to be true
      expect(h1['data']['description']).to be true
      expect(h1['data']['maxusers']).to be nil
    end
  end
end