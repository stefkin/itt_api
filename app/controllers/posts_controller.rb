class PostsController < ApplicationController
  def create
    Post::Create.new.call(post_params) do |either|
      either.success { |attrs| render json: { post: attrs } }
      either.failure { |errors| render json: { errors: errors }, status: 422 }
    end
  end

  def index
    render json: { posts: Post::TopRated.new(params[:count]).call }
  end

  private

  def post_params
    params.require(:post).permit(%i[
      author_ip login title content
    ])
  end
end
