# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  task_id    :integer
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'when first created' do
    subject { build :task }

    it { is_expected.to be_valid }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:comment) }
  end

  describe '.associations' do
    it { is_expected.to belong_to(:task) }
    it { is_expected.to belong_to(:user) }
  end
end
