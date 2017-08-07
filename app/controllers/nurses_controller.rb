class NursesController < ApplicationController

  def show
    @nurse = Nurse.find_by(id: params[:id])
    if @nurse
      render json: @nurse.to_json
    else
      render status: 404
    end
  end

  def create
    @nurse = Nurse.new(nurse_params)
    if !@nurse.save
      render status: 400, json: {errors: @nurse.errors.full_messages}
    end
  end

  def update
    @nurse = Nurse.find_by(id: params[:id])
    if @nurse
      if !@nurse.update_attributes(update_nurse_params)
        render status: 400, json: {errors: @nurse.errors.full_messages}
      end
    else
      render status: 404
    end
  end

  def destroy
    if Nurse.find_by(id: params[:id]) == nil
      render status: 404
    else
      Nurse.find(params[:id]).destroy
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
