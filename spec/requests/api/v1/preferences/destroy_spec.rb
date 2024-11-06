require 'rails_helper'

describe 'DELETE /api/v1/preferences/:id', type: :request do
  let(:user) { create(:user) }
  let(:preference) { create(:preference, user: user) }
  let(:headers) { auth_headers }

  before { sign_in user }

  context 'with a valid token' do
    it 'returns a successful response' do
      delete api_v1_preference_path(preference), headers: headers, as: :json
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the preference' do
        expect {
          delete api_v1_preference_path(preference), headers: headers, as: :json
        }.to change { Preference.exists?(preference.id) }.from(true).to(false)
    end
  end

  context 'when the preference does not exist' do
    it 'does not change the preference count' do
      expect {
        delete api_v1_preference_path(-1), headers: headers, as: :json
      }.not_to change(Preference, :count)
    end

    it 'returns a response status indicating failure' do
      delete api_v1_preference_path(-1), headers: headers, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
