class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile, only: [:show, :edit, :update, :private_page, :change_privacy]
  before_action :public, only: [:show, :edit]
 
  def show 
  end

  def new
    @profile = Profile.new
  end

  def create 
    @profile = Profile.create(profile_params)
    @profile.user = current_user
    current_user.profile_id = @profile.id
    if @profile.save
      flash[:notice] = 'Profile Created!'
      redirect_to @profile
    else
      render :new
    end
  end

  def edit 
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = 'Task Updated!'
      redirect_to profile_path(@profile), method: :put
    else
      render :edit
    end 
  end

  def change_privacy
    @profile.update(privacy_params)
    redirect_to profile_path(@profile)
  end

  def private_page 
  end

  private 

  def profile_params
    params.require(:profile).permit(
      :nickname,
      :bio,
      :user_id,
      :avatar
    )
  end 

  def privacy_params
    params.require(:profile).permit(:share)
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def public
    if current_user.profile
      unless (current_user.profile.id == (params[:id]).to_i) # params[:id] it's a string
        @profile = Profile.find(params[:id])
        unless  @profile.share
          redirect_to private_page_profile_path(@profile)
        end
      end
    end
  end

end
  
