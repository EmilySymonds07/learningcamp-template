require 'rails_helper'

describe 'DELETE /api/v1/preferences/:id', type: :request do
  let(:user) { create(:user) }
  let(:preference) { create(:preference, user: user) }
  let(:headers) { auth_headers }

  before { sign_in user }

  subject { delete api_v1_preference_path(preference), headers: headers, as: :json }

  context 'with a valid token' do
    it 'returns a successful response' do
      subject
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the preference' do
        expect {subject}.to change { Preference.exists?(preference.id) }.from(true).to(false)
    end
  end

  context 'when the preference does not exist' do
    let(:preference) { -1 }
  
    it 'does not change the preference count' do
      expect { subject }.not_to change(Preference, :count)
    end

    it 'returns a response status indicating failure' do
      subject
      expect(response).to have_http_status(:not_found)
    end
  end
end
