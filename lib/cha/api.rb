# coding: utf-8

module Cha
  module API
    # Get own information
    #
    # @return [Hashie::Mash]
    def me
      get('me')
    end

    # Get unread count and uncompleted tasks count
    #
    # @return [Hashie::Mash]
    def my_status
      get('my/status')
    end

    # Get list of my tasks
    #
    # @param params [Hash] Hash of optional parameter
    # @option params [Integer] :assigned_by_account_id (nil)
    #   Account ID of tasks client
    # @option params [Symbol] :status (:open)
    #   Tasks status (open, done)
    # @return [Array<Hashie::Mash>]
    def my_tasks(params = {})
      get('my/tasks', params)
    end

    # Get list of contacts
    #
    # @return [Array<Hashie::Mash>]
    def contacts
      get('contacts')
    end

    # Get list of chat rooms
    #
    # @return [Array<Hashie::Mash>]
    def rooms
      get('rooms')
    end

    # Create new chat room
    #
    # @param name [String] Name of chat room
    # @param members_admin_ids [Array<Integer>]
    #   Array of member ID that want to admin authority
    # @param params [Hash] Hash of optional parameter
    # @option params [String] :description (nil) Summary of chat room
    # @option params [Symbol] :icon_preset (nil) Kind of Icon of chat room
    #   (group, check, document, meeting, event, project, business, study,
    #   security, star, idea, heart, magcup, beer, music, sports, travel)
    # @option params [Array<Integer>] :members_member_ids (nil)
    #   Array of member ID that want to member authority
    # @option params [Array<Integer>] :members_readonly_ids (nil)
    #   Array of member ID that want to read only
    # @return [Hashie::Mash]
    def create_room(name, members_admin_ids, params = {})
      members_admin_ids = array_to_string(members_admin_ids)
      if value = params[:members_member_ids]
        params[:members_member_ids] = array_to_string(value)
      end
      if value = params[:members_readonly_ids]
        params[:members_readonly_ids] = array_to_string(value)
      end
      params = params.merge(name: name, members_admin_ids: members_admin_ids)
      post('rooms', params)
    end

    # Get chat room information
    #
    # @param room_id [Integer] ID of chat room
    # @return [Hashie::Mash]
    def room(room_id)
      get("rooms/#{room_id}")
    end

    # Update chat room information
    #
    # @param room_id [Integer] ID of chat room
    # @param params [Hash] Hash of optional parameter
    # @option params [String] :name (nil) Name of chat room
    # @option params [String] :description (nil) Summary of chat room
    # @option params [Symbol] :icon_preset (nil) Kind of Icon of chat room
    #   (group, check, document, meeting, event, project, business, study,
    #   security, star, idea, heart, magcup, beer, music, sports, travel)
    # @return [Hashie::Mash]
    def update_room(room_id, params = {})
      put("rooms/#{room_id}", params)
    end

    # Leave or delete of chat room
    #
    # @param room_id [Integer] ID of chat room
    # @param action_type [Symbol] Leave or delete (leave, delete)
    # @return [Hashie::Mash]
    def destroy_room(room_id, action_type)
      delete("rooms/#{room_id}", action_type: action_type)
    end

    # Get list of chat room members
    #
    # @param room_id [Integer] ID of chat room
    # @return [Array<Hahsie::Mash>]
    def room_members(room_id)
      get("rooms/#{room_id}/members")
    end

    # Update chat room members
    #
    # @param room_id [Integer] ID of chat room
    # @param members_admin_ids [Array<Integer>]
    #   Array of member ID that want to admin authority
    # @param params [Hash] Hash of optional parameter
    # @option params [Array<Integer>] :members_member_ids (nil)
    #   Array of member ID that want to member authority
    # @option params [Array<Integer>] :members_readonly_ids (nil)
    #   Array of member ID that want to read only
    # @return [Hahsie::Mash]
    def update_room_members(room_id, members_admin_ids, params = {})
      members_admin_ids = array_to_string(members_admin_ids)
      if value = params[:members_member_ids]
        params[:members_member_ids] = array_to_string(value)
      end
      if value = params[:members_readonly_ids]
        params[:members_readonly_ids] = array_to_string(value)
      end
      params = params.merge(members_admin_ids: members_admin_ids)
      put("rooms/#{room_id}/members", params)
    end

    # Get list of chat room messages
    #
    # @param room_id [Integer] ID of chat room
    # @param params [Hash] Hash of optional parameter
    # @option params [Boolean] :force (nil)
    #   Whether to get the latest 100 Reviews regardless of the non-acquired
    # @return [Array<Hashie::Mash>]
    def room_messages(room_id, params = {})
      force = boolean_to_integer(params[:force])
      get("rooms/#{room_id}/messages", force: force)
    end

    # Create new message of chat room
    #
    # @param room_id [Integer] ID of chat room
    # @param body [String] Message body
    # @return [Hashie::Mash]
    def create_room_message(room_id, body)
      post("rooms/#{room_id}/messages", body: body)
    end

    # Get message information
    #
    # @param room_id [Integer] ID of chat room
    # @param message_id [Integer] ID of message
    # @return [Hashie::Mash]
    def room_message(room_id, message_id)
      get("rooms/#{room_id}/messages/#{message_id}")
    end

    # Get list of chat room tasks
    #
    # @param room_id [Integer] ID of chat room
    # @param params [Hash] Hash of optional parameter
    # @option params [Integer] :account_id (nil)
    #   Account ID of task person in charge
    # @option params [Integer] :assigned_by_account_id (nil)
    #   Account ID of task client
    # @option params [Symbol] :status (:open) Task status (open, done)
    # @return [Array<Hashie::Mash>]
    def room_tasks(room_id, params = {})
      get("rooms/#{room_id}/tasks", params)
    end

    # Create new task of chat room
    #
    # @param room_id [Integer] ID of chat room
    # @param body [String] Contents of task
    # @param to_ids [Array<Integer>] Array of account ID of person in charge
    # @param params [Hash] Hash of optional parameter
    # @option params [Integer, Time] :limit (nil) Deadline of task (unix time)
    # @return [Hashie::Mash]
    def create_room_task(room_id, body, to_ids, params = {})
      to_ids = array_to_string(to_ids)
      if value = params[:limit]
        params[:limit] = time_to_integer(value)
      end
      post("rooms/#{room_id}/tasks", params.merge(body: body, to_ids: to_ids))
    end

    # Get task information
    #
    # @param room_id [Integer] ID of chat room
    # @param task_id [Integer] ID of task
    # @return [Hashie::Mash]
    def room_task(room_id, task_id)
      get("rooms/#{room_id}/tasks/#{task_id}")
    end

    # Get list of chat room files
    #
    # @param room_id [Integer] ID of chat room
    # @param params [Hash] Hash of optional parameter
    # @option params [Integer] :account_id (nil) Account ID of who uploaded
    # @return [Array<Hashie::Mash>]
    def room_files(room_id, params = {})
      get("rooms/#{room_id}/files", params)
    end

    # Get file information
    #
    # @param room_id [Integer] ID of chat room
    # @param file_id [Integer] ID of file
    # @param params [Hash] Hash of optional parameter
    # @option params [Boolean] :create_download_url (false)
    #   Create URL for download
    def room_file(room_id, file_id, params = {})
      unless (value = params[:create_download_url]).nil?
        params[:create_download_url] = boolean_to_integer(value)
      end
      get("rooms/#{room_id}/files/#{file_id}", params)
    end

    private

    def boolean_to_integer(value)
      ['true', '1'].include?(value.to_s) ? 1 : 0
    end

    def array_to_string(value)
      [value].flatten.join(',')
    end

    def time_to_integer(value)
      case value
      when Integer
        value
      when Time
        value.to_i
      end
    end
  end
end
