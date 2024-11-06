require 'rails_helper'

describe 'PUT api/v1/preferences/:id' do
  subject { put api_v1_preference_path(preference), params: { preference: attributes }, headers: headers, as: :json }

  let(:user) { create(:user) }
  let(:preference) { create(:preference, user: user) }
  let(:headers) { auth_headers }

  let(:valid_attributes) do
    { name: "Updated Name", description: "Updated Description", restriction: false }
  end

  let(:invalid_attributes) do
    { name: nil, description: nil, restriction: nil }
  end

  context 'with valid parameters' do
    let(:attributes) { valid_attributes }

    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'updates the preference' do
      subject
      expect(preference.reload.name).to eq(valid_attributes[:name])
    end

    it 'returns the preference id' do
      subject
      json_response = JSON.parse(response.body).with_indifferent_access
      expect(json_response[:preference][:id]).to eq preference.id
    end

    it 'returns the preference name' do
      subject
      json_response = JSON.parse(response.body).with_indifferent_access
      expect(json_response[:preference][:name]).to eq preference.reload.name
    end
  end

  context 'with invalid parameters' do
    let(:attributes) { invalid_attributes }

    it 'returns a client error' do
      subject
      expect(response).to have_http_status(:bad_request)
    end

    it 'does not update the preference' do
      subject
      expect(preference.reload.name).not_to eq(invalid_attributes[:name])
    end

    it 'returns the error messages' do
      subject
      json_response = JSON.parse(response.body).with_indifferent_access
      expect(json_response[:errors][0]['name']).to include("can't be blank")
      expect(json_response[:errors][0]['description']).to include("can't be blank")
      expect(json_response[:errors][0]['restriction']).to include("is not included in the list")
    end
  end

  context 'with missing parameters' do
    let(:attributes) { {} }

    it 'returns the missing params error' do
      subject
      json_response = JSON.parse(response.body).with_indifferent_access
      expect(json_response[:errors][0][:message]).to eq 'A required param is missing'
    end
  end
end
