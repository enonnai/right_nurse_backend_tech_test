class NursesController < ApplicationController

  def create
    @nurse = Nurse.new(nurse_params)
    if !@nurse.save
      render status: 400, json: {errors: @nurse.errors.full_messages}
    end
  end

  def update
    @nurse = Nurse.find(params[:id])
    if !@nurse.update_attributes(update_nurse_params)
      render status: 400, json: {errors: @nurse.errors.full_messages}
    end
  end

  private

  def nurse_params
    params.require(:nurse).permit(:email, :first_name, :last_name, :phone_number, :verified, :sign_in_count, :role_id)
  end

  def update_nurse_params
    params.require(:nurse).permit(:email, :first_name, :last_name, :phone_number, :role_id)
  end
end
