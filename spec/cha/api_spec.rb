# coding: utf-8

require 'spec_helper'

describe Cha::API do
  let(:api_token) { 'api_token' }
  let(:client) { Cha.new(api_token: api_token) }

  describe '#me' do
    it 'should request the correct resource' do
      stub_get('me')
      client.me
    end
  end

  describe '#my_status' do
    it 'should request the correct resource' do
      stub_get('my/status')
      client.my_status
    end
  end

  describe '#my_tasks' do
    it 'should request the correct resource' do
      stub_get('my/tasks')
      client.my_tasks
    end
  end

  describe '#contacts' do
    it 'should request the correct resource' do
      stub_get('contacts')
      client.contacts
    end
  end

  describe '#rooms' do
    it 'should request the correct resource' do
      stub_get('rooms')
      client.rooms
    end
  end

  describe '#create_room' do
    it 'should request the correct resource' do
      stub_post('rooms')
        .with(body: {name: 'nyan', members_admin_ids: '1,2', members_member_ids: '3,4', members_readonly_ids: '5,6'})
      client.create_room('nyan', [1, 2], members_member_ids: [3, 4], members_readonly_ids: [5, 6])
    end
  end

  describe '#room' do
    it 'should request the correct resource' do
      stub_get('rooms/1')
      client.room(1)
    end
  end

  describe '#update_room' do
    it 'should request the correct resource' do
      stub_put('rooms/1')
        .with(body: {name: 'wan'})
      client.update_room(1, name: 'wan')
    end
  end

  describe '#destroy_room' do
    it 'should request the correct resource' do
      stub_delete('rooms/1')
        .with(query: {action_type: 'leave'})
      client.destroy_room(1, :leave)
    end
  end

  describe '#room_members' do
    it 'should request the correct resource' do
      stub_get('rooms/1/members')
      client.room_members(1)
    end
  end

  describe '#update_room_members' do
    it 'should request the correct resource' do
      stub_put('rooms/1/members')
        .with(body: {members_admin_ids: '1,2', members_member_ids: '3,4', members_readonly_ids: '5,6'})
      client.update_room_members(1, [1, 2], members_member_ids: [3, 4], members_readonly_ids: [5, 6])
    end
  end

  describe '#create_room_message' do
    it 'should request the correct resource' do
      stub_post('rooms/1/messages')
        .with(body: {body: 'nyan'})
      client.create_room_message(1, 'nyan')
    end
  end

  describe '#room_messages' do
    it 'should request the correct resource' do
      stub_get('rooms/1/messages')
      client.room_messages(1)
    end
  end

  describe '#room_message' do
    it 'should request the correct resource' do
      stub_get('rooms/1/messages/1')
      client.room_message(1, 1)
    end
  end

  describe '#room_tasks' do
    it 'should request the correct resource' do
      stub_get('rooms/1/tasks')
      client.room_tasks(1)
    end
  end

  describe '#create_room_task' do
    let(:current_time) { Time.now }

    it 'should request the correct resource' do
      stub_post('rooms/1/tasks')
        .with(body: {body: 'nyan', to_ids: '1,2', limit: current_time.to_i.to_s})
      client.create_room_task(1, 'nyan', [1, 2], limit: current_time)
      client.create_room_task(1, 'nyan', [1, 2], limit: current_time.to_i)
    end
  end

  describe '#room_task' do
    it 'should request the correct resource' do
      stub_get('rooms/1/tasks/1')
      client.room_task(1, 1)
    end
  end

  describe '#room_files' do
    it 'should request the correct resource' do
      stub_get('rooms/1/files')
      client.room_files(1)
    end
  end

  describe '#room_file' do
    it 'should request the correct resource' do
      stub_get('rooms/1/files/1')
      client.room_file(1, 1)

      stub_get('rooms/1/files/1')
        .with(query: {create_download_url: '1'})
      client.room_file(1, 1, create_download_url: true)

      stub_get('rooms/1/files/1')
        .with(query: {create_download_url: '0'})
      client.room_file(1, 1, create_download_url: false)
    end
  end
end
