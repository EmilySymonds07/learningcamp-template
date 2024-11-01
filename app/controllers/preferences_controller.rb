# frozen_string_literal: true

class PreferencesController < ApplicationController
  def index
    @preferences = current_user.preferences
    @pagy, @records = pagy(@preferences)
  end

  def show
    @preference = Preference.find(params[:id])
  end

  def edit
    @preference = Preference.find(params[:id])
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
    @preference.destroy
    redirect_to preferences_path, notice: 'Preference was successfully deleted.'
  end

  def new
    @preference = Preference.new
    render :new
  end

  def create
    @preference = current_user.preferences.build(preference_params)
    if @preference.save
      @preference.save!
      redirect_to preferences_path, notice: t('views.preferences.create_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def preference_params
    params.require(:preference).permit(:name, :description, :restriction)
  end
end

