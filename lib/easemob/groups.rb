module Easemob
  module Groups
    def create_group(name, desc, owner, members: nil, is_public: true, maxusers: 200, is_approval: false)
      jd = { groupname: name, desc: desc, public: is_public, owner: owner, users: maxusers, approval: is_approval }
      jd[:members] = members unless members.nil?
      request :post, 'chatgroups', json: jd
    end

    def modify_group(group_id, name, desc, maxusers = nil)
      jd = { groupname: name, description: desc }
      jd[:maxusers] = maxusers unless maxusers.nil?
      request :put, "chatgroups/#{group_id}", json: jd
    end
  end
end
