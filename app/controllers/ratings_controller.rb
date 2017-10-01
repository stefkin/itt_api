class RatingsController < ApplicationController
  def create
    Rating::Create.new.call(rating_params) do |either|
      either.success { |avg_value|
        render_json_oj({ avg_value: avg_value })
      }
      either.failure { |errors| render json: { errors: errors }, status: 422 }
    end
  end

  private

  def rating_params
    params.require(:rating).permit(%i[post_id value])
  end
end
