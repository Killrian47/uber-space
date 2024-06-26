class SpaceshipsController < ApplicationController
  before_action :set_spaceship, only: [:show]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @spaceships = Spaceship.all
  end

  def show
    @booking = Booking.new
    @favorite = Favorite.new
    current_user.favorites.each do |favorite|
      if favorite.spaceship == @spaceship
        @favorite = favorite
      end
    end
  end

  def new
    @spaceship = Spaceship.new
    @spaceship.user = current_user
  end

  def create
    @spaceship = Spaceship.new(spaceship_params)
    @spaceship.user = current_user
    if @spaceship.save
      redirect_to spaceship_path(@spaceship)
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def set_spaceship
    @spaceship = Spaceship.find(params[:id])
  end

  def spaceship_params
    params.require(:spaceship).permit(:name, :fuel, :number_of_places, :price_per_day, :description, :is_available, :main_image, secondary_images: [])
  end
end
