require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it 'has valid factory' do
      user = build :user
      expect(user).to be_valid
    end
  end
end
