# frozen_string_literal: true

module API
  module V1
    class PreferencesController < API::V1::APIController
      def index
        @preferences = current_user.preferences
        @pagy, @records = pagy(@preferences)
      end

      def show
        @preference = Preference.find(params[:id])
      end

      def create
        @preference = current_user.preferences.build(preference_params)
        @preference.save!
      end

      def update
        @preference = Preference.find(params[:id])
        if @preference.update(preference_params)
          redirect_to preferences_path, notice: 'Preference was successfully updated.'
        else
          render :edit
        end
      end

      def destroy
        @preference = Preference.find(params[:id])
        @preference.destroy!
        redirect_to preferences_path, notice: 'Preference was successfully deleted.'
      end

      private

      def preference_params
        params.require(:preference).permit(:name, :description, :restriction)
      end
    end
  end
end
