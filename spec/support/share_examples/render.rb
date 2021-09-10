RSpec.shared_examples 'render correct template' do |template|
  it { is_expected.to render_template(template) }
  it { is_expected.to have_http_status(:ok) }
end
