# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET /index' do
    subject { get :index }

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
end
