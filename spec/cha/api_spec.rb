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
    pending
  end

  describe '#room' do
    it 'should request the correct resource' do
      stub_get('rooms/1')
      client.room(1)
    end
  end

  describe '#update_room' do
    pending
  end

  describe '#destroy_room' do
    pending
  end

  describe '#room_members' do
    it 'should request the correct resource' do
      stub_get('rooms/1/members')
      client.room_members(1)
    end
  end

  describe '#update_room_members' do
    pending
  end

  describe '#room_messages' do
    it 'should request the correct resource' do
      stub_get('rooms/1/messages')
      client.room_messages(1)
    end
  end

  describe '#create_room_message' do
    pending
  end

  describe '#room_message' do
    pending
  end

  describe '#room_tasks' do
    it 'should request the correct resource' do
      stub_get('rooms/1/tasks')
      client.room_tasks(1)
    end
  end

  describe '#create_room_task' do
    pending
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
    end
  end
end
