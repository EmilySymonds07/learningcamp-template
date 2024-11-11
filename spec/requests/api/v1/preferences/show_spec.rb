# frozen_string_literal: true
require 'rails_helper'

describe 'GET api/v1/preferences/:id' do
    subject { get api_v1_preference_path(preference), headers: auth_headers, as: :json }
  
    let(:user) { create(:user) }
    let(:preference) { create(:preference, user: user) }
  
    before { sign_in user }
  
    it 'returns success' do
      subject
      expect(response).to have_http_status(:success)
    end
  
    it "returns the preference's id" do
      subject
      expect(json[:preference][:id]).to eq(preference.id)
    end
  
    it "returns the preference's name" do
      subject
      expect(json[:preference][:name]).to eq(preference.name)
    end
  
    it "returns the preference's description" do
      subject
      expect(json[:preference][:description]).to eq(preference.description)
    end
  
    it "returns the preference's restriction status" do
      subject
      expect(json[:preference][:restriction]).to eq(preference.restriction)
    end
  
    context 'when record is not found' do
      let(:preference) { double(id: 0) } # Usa un ID inexistente
  
      it 'returns status 404 not found' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end
  end