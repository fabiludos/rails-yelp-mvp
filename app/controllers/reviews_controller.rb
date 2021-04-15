class ReviewsController < ApplicationController
  before_action :find_review, only: [:destroy]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # @review = Review.new(review_params)
    # @restaurant = Restaurant.find(params[:restaurant_id])
    # @review.restaurant = @restaurant
    # if @review.save
    #   redirect_to restaurant_path(@restaurant)
    # else
    #   render :new
    # end
    @review = Review.new(review_params)
    # we need `restaurant_id` to associate review with corresponding restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def destroy
    @restaurant = @review.restaurant
    @review.destroy
    redirect_to restaurant_path(@restaurant)
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
