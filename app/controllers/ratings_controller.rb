class RatingsController < ApplicationController
  def create
    Rating::Create.new.call(rating_params) do |either|
      either.success { |rating|
        render_json_oj({ avg_value: Post::AvgRating.new(rating.post_id).call })
      }
      either.failure { |errors| render json: { errors: errors }, status: 422 }
    end
  end

  private

  def rating_params
    params.require(:rating).permit(%i[post_id value])
  end
end
