class RatingsController < ApplicationController
  def create
    Rating::Create.new.call(params[:rating]) do |either|
      either.success { |rating|
        render json: { avg_value: Post::AvgRating.new(rating.post_id).call }
      }
      either.failure { |errors| render json: { errors: errors }, status: 422 }
    end
  end
end
