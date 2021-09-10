RSpec.shared_examples 'redirect_to login' do
  context 'when not sign in' do
    it { is_expected.to redirect_to(user_session_path) }
  end
end
