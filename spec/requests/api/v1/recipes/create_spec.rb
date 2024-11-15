require 'rails_helper'

describe 'POST /api/v1/recipes', type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST #create' do
    subject { post api_v1_recipes_path, params: { recipe: recipe_params }, as: :json }

    context 'with valid attributes' do
      let(:recipe_params) do
        {
          name: 'Sardine Salad',
          description: 'A delicious sardine salad.',
          ingredients: 'Sardines, lettuce, tomatoes'
        }
      end

      it 'creates a new recipe and returns success' do
        expect { subject }.to change(Recipe, :count).by(1)
        expect(response).to have_http_status(:ok)
      end

      it 'returns the created recipe' do
        subject
        recipe = Recipe.last
        json_response = JSON.parse(response.body).with_indifferent_access
        expect(json_response[:id]).to eq(recipe.id)
        expect(json_response[:name]).to eq(recipe_params[:name])
        expect(json_response[:description]).to eq(recipe_params[:description])
        expect(json_response[:ingredients]).to eq(recipe_params[:ingredients])
      end
    end

    context 'with invalid attributes' do
      let(:recipe_params) { { name: nil, description: nil, ingredients: nil } }

      it 'does not create a new recipe and returns a client error' do
        expect { subject }.not_to change(Recipe, :count)
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages upon failure' do
        subject
        json_response = JSON.parse(response.body).with_indifferent_access
        expect(json_response[:errors][0]['name']).to include("can't be blank")
        expect(json_response[:errors][0]['description']).to include("can't be blank")
        expect(json_response[:errors][0]['ingredients']).to include("can't be blank")
      end
    end
  end
end
