# frozen_string_literal: true

RSpec.shared_examples 'index' do |status, done|
  it 'returns correct tasks' do
    get :index, params: { status: status }
    aggregate_failures 'testing number of tasks' do
      expect(assigns(:tasks)).to be_empty
      create_list(:task, 3, user: user, done: done)
      expect(assigns(:tasks).count).to eq 3
    end
  end
end
