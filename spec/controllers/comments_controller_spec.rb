# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    subject do
      post :create, params: {
        task_id: task.id,
        user_id: user.id,
        comment: { comment: comment }
      }
    end

    let(:user) { create :user }
    let(:task) { create :task }
    let(:comment) { '' }

    context 'when not sign in' do
      it { is_expected.to redirect_to(user_session_path) }
    end

    context 'when sign in' do
      before { sign_in user }

      it 'renders new given invalid input' do
        expect(subject).to render_template(:new)
      end
    end
  end
end
