# frozen_string_literal: true
require 'rails_helper'

describe 'POST /api/v1/preferences', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST #create' do
    subject { post api_v1_preferences_path, params: { preference: preference_params }, as: :json }

    context 'with valid attributes' do
      let(:preference_params) do
        {
          name: 'Vegan',
          description: 'No animal products',
          restriction: true
        }
      end

      it 'creates a new preference and returns success' do
        expect { subject }.to change(Preference, :count).by(1)
        expect(response).to have_http_status(:success)
      end

      it 'returns the created preference' do :aggregate_failures
        subject
        preference = Preference.last
        expect(json[:preference][:id]).to eq(preference.id)
        expect(json[:preference][:name]).to eq(preference_params[:name])
        expect(json[:preference][:description]).to eq(preference_params[:description])
        expect(json[:preference][:restriction]).to eq(preference_params[:restriction])
      end
    end

    context 'with invalid attributes' do
      let(:preference_params) { { name: nil, description: nil, restriction: nil } }

      it 'does not create a new preference and returns a client error' do
        expect { subject }.not_to change(Preference, :count)
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages upon failure' do :aggregate_failures
        subject
        json_response = JSON.parse(response.body).with_indifferent_access
        expect(json_response[:errors][0]['name']).to include("can't be blank")
        expect(json_response[:errors][0]['description']).to include("can't be blank")
        expect(json_response[:errors][0]['restriction']).to include("is not included in the list")

      end
    end
  end
end
