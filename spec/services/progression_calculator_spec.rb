# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProgressionCalculator, type: :model do
  describe '#call' do
    subject { described_class.new(user).call }

    let(:user) { create :user }

    context 'when there is no tasks' do
      it 'returns zero' do
        expect(subject).to eq 0
      end
    end

    context 'when all tasks are in progressed' do
      it 'return zero' do
        create_list(:task, 3, user: user, done: false)
        expect(subject).to eq 0
      end
    end

    context 'when half of the tasks are done' do
      it 'returns 50%' do
        create_list(:task, 3, user: user, done: false)
        create_list(:task, 3, user: user, done: true)
        expect(subject).to eq 50
      end
    end

    context 'when all tasks are closed' do
      it 'return 100%' do
        create_list(:task, 3, user: user, done: true)
        expect(subject).to eq 100
      end
    end
  end
end
