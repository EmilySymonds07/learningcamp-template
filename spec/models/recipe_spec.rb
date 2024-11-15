# == Schema Information
#
# Table name: recipes
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  ingredients :text
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#
require 'rails_helper'

describe Recipe do
    describe 'validations' do
        subject { build(:recipe) }

        it { is_expected.to validate_presence_of(:name) }
        it { is_expected.to validate_presence_of(:description) }
        it { is_expected.to validate_presence_of(:ingredients) }
    end
    
    describe 'associations' do
        it { is_expected.to belong_to(:user) }
    end
end    
