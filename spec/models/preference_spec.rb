require 'rails_helper'

describe Preference do
    describe 'validations' do
        subject { build(:preference) }

        it { is_expected.to validate_presence_of(:name) }
        it { is_expected.to validate_presence_of(:description) }
        it { is_expected.to validate_inclusion_of(:restriction).in_array([true, false]) }
    end
    
    describe 'associations' do
        it { is_expected.to belong_to(:user) }
    end
end    