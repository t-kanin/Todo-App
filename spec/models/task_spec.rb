# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#validations' do
    let(:task) { build :task }

    context 'when there is no name' do
      it 'returns invalid' do
        task.name = ''
        expect(task).not_to be_valid
      end
    end

    context 'when there is name' do
      it 'returns valid' do
        expect(task).to be_valid
      end
    end

    context 'when there is no user' do
      it 'returns invalid' do
        task.user = nil
        expect(task).not_to be_valid
      end
    end

    context 'when name is too short' do
      it 'returns invalid' do
        task.name = 'ab'
        expect(task).not_to be_valid
      end
    end
  end
end
