# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET /index' do
    subject { get :index, params: {} }

    include_examples 'redirect_to login'

    context 'when user signs in' do
      let(:user) { create :user }

      before { sign_in user }
      it_behaves_like 'render correct template', :index
      # /tasks/?status=close
      it_behaves_like 'index', ['', false]
      it_behaves_like 'index', ['open', false]
      it_behaves_like 'index', ['close', true]
    end
  end

  describe 'GET /show' do
    subject { get :show, params: { id: task.id } }

    let(:task)  { create :task }
    let(:task2) { create :task }
    let(:user)  { create :user }

    include_examples 'redirect_to login'

    context 'when user signs in' do
      before { sign_in user }
      it_behaves_like 'render correct template', :show

      it 'shows the same task' do
        subject
        expect(assigns(:task)).to eq task
        create_list(:comment, 3, task: task, user: user)
        expect(assigns(:task).comments.count).to eq 3
      end
    end
  end

  describe 'POST #create' do
    subject do
      post :create, params: { task: {
        name: task.name,
        description: task.description,
        done: task.done,
        user_id: user.id
      } }
    end

    let(:user) { create :user }
    let(:task) { build :task, user: user }

    it { is_expected.to redirect_to(user_session_path) }

    context 'when sign in' do
      before { sign_in user }
      it 'creates task' do
        expect { subject }.to change(Task, :count).by(1)
        expect(response).to redirect_to(assigns(:task))
      end

      it 'renders new' do
        post :create, params: { task: { name: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: task.id } }

    let(:user) { create :user }
    let(:task) { create :task }

    context 'when not sign in' do
      it { is_expected.to redirect_to(user_session_path) }
    end

    context 'when sign in' do
      before { sign_in user }
      it { is_expected.to render_template(:edit) }

      it 'returns the same task' do
        subject
        expect(assigns(:task)).to eq task
      end
    end
  end

  describe 'PATCH #update' do
    subject { patch :update, params: { id: task.id, task: { name: 'new name' } } }

    let(:user) { create :user }
    let(:task) { create :task }

    context 'when not sign in' do
      it { is_expected.to redirect_to(user_session_path) }
    end

    context 'when sign in' do
      before { sign_in user }

      it 'changes name' do
        subject
        expect(response).to redirect_to(assigns(:task))
        expect(assigns(:task).name).to match('new name')
      end
    end
  end
end
