# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    subject do
      post :create, params: {
        task_id: task.id,
        user_id: user.id,
        comment: { comment: 'This is my new comment' }
      }
    end

    let(:user) { create :user }
    let(:task) { create :task }

    context 'when not sign in' do
      it { is_expected.to redirect_to(user_session_path) }
    end

    context 'when sign in' do
      before { sign_in user }

      it 'renders new given invalid input' do
        subject { post :create, params: {} }
        expect { subject }.to change(Comment, :count).by 0
      end

      it 'creates comment and redirect to task' do
        aggregate_failures do
          expect { subject }.to change(Comment, :count).by 1
          expect(response).to redirect_to(assigns(:task))
        end
      end
    end
  end
end
