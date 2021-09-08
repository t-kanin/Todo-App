# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  done        :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  user_id     :integer
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'when first created' do
    subject { build :task }

    it { is_expected.to be_valid }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '.associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
  end
end
