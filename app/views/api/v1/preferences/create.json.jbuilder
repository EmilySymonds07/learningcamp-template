# frozen_string_literal: true

# views/api/v1/preferences/create.json.jbuilder
json.preference do
  json.id          @preference.id
  json.name        @preference.name
  json.description @preference.description
  json.restriction @preference.restriction
  json.user_id     @preference.user_id
  json.created_at  @preference.created_at
  json.updated_at  @preference.updated_at
end
