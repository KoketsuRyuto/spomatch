class Admin::SportsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @sport = Sport.new
    @sports = Sport.all
  end
  
  def create
    @sport = Sport.new(sport_params)
    @sport.save
    redirect_to admin_sports_path
  end

  def edit
    @sport = Sport.find(params[:id])
  end
  
  def update
    @sport = Sport.find(params[:id])
    @sport.update(update_params)
    redirect_to admin_sports_path
  end
  
  def destroy
    @sport = Sport.find(params[:id])
    @sport.destroy
    redirect_to admin_sports_path
  end
  
  private
  
  def sport_params
    params.require(:sport).permit(:name)
  end
  
  def update_params
    params.require(:sport).permit(:name)
  end
end
