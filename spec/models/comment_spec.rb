# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#validations' do
    let(:comment) { build :comment }

    it 'has valid object' do
      expect(comment).to be_valid
    end

    it 'returns invalid when no user' do
      comment.user = nil
      expect(comment).not_to be_valid
    end

    it 'returns invalid when no task' do
      comment.task = nil
      expect(comment).not_to be_valid
    end
  end
end
