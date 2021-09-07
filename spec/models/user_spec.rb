require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    let(:user) { build :user }

    context 'when there is no email' do
      it 'returns invalid' do
        user.email = ''
        expect(user).not_to be_valid
      end
    end

    context 'when there is invalid email' do
      let(:user1) { build :user, email: 'aa@@exmaple.com' }
      let(:user2) { build :user, email: 'a.com' }

      it 'returns invalid' do
        aggregate_failures do
          expect(user1).not_to be_valid
          expect(user2).not_to be_valid
        end
      end
    end

    context 'when there is same email' do
      let(:user)  { create :user }
      let(:user1) { build :user, email: user.email }
      it 'returns invalid' do
        expect(user1).not_to be_valid
      end
    end
  end
end
