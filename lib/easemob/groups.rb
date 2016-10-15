module Easemob
  module Groups
    def create_group(groupname, description, owner, members: nil, is_public: true, maxusers: 200, is_approval: false)
      jd = { groupname: groupname, desc: description, public: is_public, owner: owner, users: maxusers, approval: is_approval }
      jd[:members] = members unless members.nil?
      request :post, 'chatgroups', json: jd
    end

    def get_group(group_id)
      request :get, "chatgroups/#{group_id}"
    end

    def get_groups(group_ids)
      request :get, "chatgroups/#{group_ids.join(',')}"
    end

    def query_groups(limit = 50, cursor = nil)
      params = { limit: limit }
      params[:cursor] = cursor unless cursor.nil?
      request :get, 'chatgroups', params: params
    end

    def query_group_users(group_id)
      request :get, "chatgroups/#{group_id}/users"
    end

    def delete_group(group_id)
      request :delete, "chatgroups/#{group_id}"
    end

    def modify_group(group_id, groupname: nil, description: nil, maxusers: nil)
      jd = {}
      jd[:groupname] = groupname unless groupname.nil?
      jd[:description] = description unless description.nil?
      jd[:maxusers] = maxusers unless maxusers.nil?
      request :put, "chatgroups/#{group_id}", json: jd
    end

    def user_join_group(username, group_id)
      request :post, "chatgroups/#{group_id}/users/#{username}"
    end

    def user_leave_group(username, group_id)
      request :delete, "chatgroups/#{group_id}/users/#{username}"
    end
  end
end
