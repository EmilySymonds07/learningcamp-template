# frozen_string_literal: true

FactoryBot.define do
  factory :preference do
    name { 'MyString' }
    description { 'MyText' }
    restriction { false }
  end
end
