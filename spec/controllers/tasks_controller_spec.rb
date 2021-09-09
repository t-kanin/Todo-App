# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET /index' do
    subject { get :index }

    # TODO: extract sign_in context ?
    context 'when not sign in' do
      it { is_expected.to redirect_to(user_session_path) }
    end

    context 'sign in user' do
      let(:user) { create :user }
      before { sign_in user }

      it { is_expected.to render_template(:index) }
      it { is_expected.to have_http_status(:ok) }

      it 'returns all tasks' do
        subject
        aggregate_failures 'testing number of tasks' do
          expect(assigns(:tasks)).to be_empty
          create(:task, user: user)
          expect(assigns(:tasks).count).to eq 1
        end
      end
    end
  end

  describe 'GET /index_open' do
    subject { get :index_open }
    context 'sign in user' do
      let(:user) { create :user }
      before { sign_in user }

      it { is_expected.to render_template(:index_open) }
      it { is_expected.to have_http_status(:ok) }

      it 'returns open tasks' do
        subject
        # TODO: Refactor this aggregate_failures block to be used in other blocks
        aggregate_failures 'testing number of tasks' do
          expect(assigns(:tasks)).to be_empty
          create(:task, user: user)
          expect(assigns(:tasks).count).to eq 1
          create(:task, user: user, done: true)
          expect(assigns(:tasks).count).to eq 1
        end
      end
    end
  end

  describe 'GET /index_close' do
    subject { get :index_close }

    context 'sign in user' do
      let(:user) { create :user }
      before { sign_in user }

      it { is_expected.to render_template(:index_close) }
      it { is_expected.to have_http_status(:ok) }

      it 'returns close tasks' do
        subject
        aggregate_failures 'testing number of tasks' do
          expect(assigns(:tasks)).to be_empty
          create(:task, user: user)
          expect(assigns(:tasks).count).to eq 0
          create(:task, user: user)
          create(:task, user: user, done: true)
          expect(assigns(:tasks).count).to eq 1
        end
      end
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
    let(:user) { create :user }
    let(:task) { build :task, user: user }

    subject do
      post :create, params: { task: {
        name: task.name,
        description: task.description,
        done: task.done,
        user_id: user.id
      } }
    end

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
    let(:user) { create :user }
    let(:task) { create :task }
    subject { get :edit, params: { id: task.id } }

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
end
