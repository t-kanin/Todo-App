# frozen_string_literal: true

RSpec.shared_examples 'same task' do
  it 'returns the same name, description, number of comments' do
    subject
    create_list(:comment, 3, task: task, user: user)
    expect(assigns(:task)).to eq task
    expect(assigns(:task).name).to match task.name
    expect(assigns(:task).description).to match task.description
    expect(assigns(:task).comments.count).to eq 3
  end
end
