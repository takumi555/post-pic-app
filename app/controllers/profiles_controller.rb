class  ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
    @profile_build = current_user.build_profile
  end

  def edit
    @profile_build = current_user.build_profile
  end

  def update
    @profile_build = current_user.build_profile(profile_params)
    if @profile_build.save
      redirect_to profile_path, notice: 'プロフィール更新'
    else
      flash.now[:error] = '更新できませんでした'
      render :show
    end
  end

  private
  def profile_params
    params.require(:profile).permit(
      :userimage
    )
  end
end