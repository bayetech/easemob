require 'spec_helper'

RSpec.describe Easemob::Groups do
  describe '#create_group' do
    it 'can create group without any member' do
      res = Easemob.create_group('g1', 'group 1', 'u')
      expect(res.code).to eq 200
    end

    it 'can create group with group members' do
      res = Easemob.create_group 'g2', 'group 2', 'u', members: %w(u1 u2 u3)
      expect(res.code).to eq 200
    end
  end
end
