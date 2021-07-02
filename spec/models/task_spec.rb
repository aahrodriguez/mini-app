require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'Is created with default share status nil' do
    expect(Task.new.share).to eq nil
  end

  it 'Is created with default \'status\' value os 0' do
    expect(Task.new.status.to_i).to eq 0
  end

  it 'Is created with default priority of 0' do
    expect(Task.new.priority.to_i).to eq 0
  end

  it 'Description must to be present' do
    user = User.create(email: "test@test.com", password: 123123)
    task = Task.create(title: "Lorem Ipsum", user_id: user.id)
    expect(task.errors.first[1]).to eq "can't be blank"
  end

  it 'Description must to has maximus 280 characters' do
    user = User.create(email: "test@test.com", password: 123123)
    task = Task.create(title: "Lorem Ipsum", user_id: user.id, description: "a"*281)
    expect(task.errors.first[1]).to eq "is too long (maximum is 280 characters)"
  end

  it 'Title must to has minimum 4 characters' do
    user = User.create(email: "test@test.com", password: 123123)
    task = Task.create(title: "123", user_id: user.id, description: "a"*28)
    expect(task.errors.first[1]).to eq "is too short (minimum is 4 characters)"
  end

  it 'Title must to has maximus 20 characters' do
    user = User.create(email: "test@test.com", password: 123123)
    task = Task.create(title: "a"*21, user_id: user.id, description: "a"*28)
    expect(task.errors.first[1]).to eq "is too long (maximum is 20 characters)"
  end
end

