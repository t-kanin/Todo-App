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
end
