# frozen_string_literal: true
require 'rails_helper'

describe 'GET /api/v1/recipes/:id', type: :request do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:headers) { auth_headers }

  before { sign_in user }

  subject { get api_v1_recipe_path(recipe), headers: headers, as: :json }

  it 'returns success' do
    subject
    expect(response).to have_http_status(:success)
  end

  it "returns the recipe's id" do
    subject
    json_response = JSON.parse(response.body).with_indifferent_access
    expect(json_response[:recipe][:id]).to eq(recipe.id)
  end

  it "returns the recipe's name" do
    subject
    json_response = JSON.parse(response.body).with_indifferent_access
    expect(json_response[:recipe][:name]).to eq(recipe.name)
  end
  
  it "returns the recipe's description" do
    subject
    json_response = JSON.parse(response.body).with_indifferent_access
    expect(json_response[:recipe][:description]).to eq(recipe.description)
  end
  
  it "returns the recipe's ingredients" do
    subject
    json_response = JSON.parse(response.body).with_indifferent_access
    expect(json_response[:recipe][:ingredients]).to eq(recipe.ingredients)
  end  

  context 'when record is not found' do
    let(:recipe) { double(id: 0) } # Use a non-existent ID

    it 'returns status 404 not found' do
      subject
      expect(response).to have_http_status(:not_found)
    end
  end
end