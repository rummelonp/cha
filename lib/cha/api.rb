# coding: utf-8

module Cha
  module Me
    def me
      get('me')
    end
  end

  module My
    def my_status
      get('my/status')
    end

    def my_tasks
      get('my/tasks')
    end
  end

  module Contacts
    def contacts
      get('contacts')
    end
  end

  module Rooms
    def rooms
      get('rooms')
    end

    def room(room_id)
      get("rooms/#{room_id}")
    end

    def room_members(room_id)
      get("rooms/#{room_id}/members")
    end

    def room_messages(room_id)
      get("rooms/#{room_id}/messages")
    end

    def room_tasks(room_id)
      get("rooms/#{room_id}/tasks")
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
