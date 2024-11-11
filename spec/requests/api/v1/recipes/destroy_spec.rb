# frozen_string_literal: true
require 'rails_helper'

describe 'DELETE /api/v1/recipes/:id', type: :request do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:headers) { auth_headers }

  before { sign_in user }

  subject { delete api_v1_recipe_path(recipe), headers: headers, as: :json }

  context 'with a valid token' do
    it 'returns a successful response' do
      subject
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the recipe' do
      expect { subject }.to change { Recipe.exists?(recipe.id) }.from(true).to(false)
    end
  end

  context 'when the recipe does not exist' do
    let(:recipe) { double(id: -1) } # Usa un ID inexistente

    it 'does not change the recipe count' do
      expect { subject }.not_to change(Recipe, :count)
    end

    it 'returns a response status indicating failure' do
      subject
      expect(response).to have_http_status(:not_found)
    end
  end
end