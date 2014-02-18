# coding: utf-8

module Cha
  module API
    def me
      get('me')
    end

    def my_status
      get('my/status')
    end

    def my_tasks
      get('my/tasks')
    end

    def contacts
      get('contacts')
    end

    def rooms
      get('rooms')
    end

    def create_room(name, members_admin_ids, params = {})
      post('rooms', params.merge(name: name, members_admin_ids: members_admin_ids))
    end

    def room(room_id)
      get("rooms/#{room_id}")
    end

    def update_room(room_id, params = {})
      put("rooms/#{room_id}", params)
    end

    def destroy_room(room_id, action_type)
      delete("rooms/#{room_id}", action_type: action_type)
    end

    def room_members(room_id)
      get("rooms/#{room_id}/members")
    end

    def update_room_members(room_id, members_admin_ids, params = {})
      put("rooms/#{room_id}/members", params.merge(members_admin_ids: members_admin_ids))
    end

    def room_messages(room_id)
      get("rooms/#{room_id}/messages")
    end

    def create_room_message(room_id, body)
      post("rooms/#{room_id}/messages", body: body)
    end

    def room_message(room_id, message_id)
      get("rooms/#{room_id}/messages/#{message_id}")
    end

    def room_tasks(room_id)
      get("rooms/#{room_id}/tasks")
    end

    def create_room_task(room_id, body, to_ids, params = {})
      post("rooms/#{room_id}/tasks", params.merge(body: body, to_ids: to_ids))
    end

    def room_task(room_id, task_id)
      get("rooms/#{room_id}/tasks/#{task_id}")
    end

    def room_files(room_id)
      get("rooms/#{room_id}/files")
    end

    def room_file(room_id, file_id)
      get("rooms/#{room_id}/files/#{file_id}")
    end
  end
end
