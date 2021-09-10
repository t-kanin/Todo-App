# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET /index' do
    subject { get :index, params: {} }

    include_examples 'redirect_to login'

    context 'when sign in' do
      let(:user) { create :user }
      before { sign_in user }

      it { is_expected.to render_template(:index) }
      it { is_expected.to have_http_status(:ok) }

      # /tasks/?status=close
      it_behaves_like  'index', ['', false]
      it_behaves_like  'index', ['open', false]
      it_behaves_like  'index', ['close', true]
    end
  end

  describe 'GET /show' do
    context 'sign in user' do
      subject { get :show, params: { id: task.id } }
      let(:user) { create :user }
      let(:task) { create :task, user: user }

      before { sign_in user }

      it { is_expected.to render_template(:show) }
      it { is_expected.to have_http_status(:ok) }
      it 'returns a task' do
        subject
        expect(assigns(:task)).to eq task
        aggregate_failures do
          expect(assigns[:comments].count).to eq 0
          create(:comment, task: task, user: user)
          create(:comment, task: task, user: user)
          expect(assigns[:comments].count).to eq 2
        end
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
