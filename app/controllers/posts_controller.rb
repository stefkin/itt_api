class PostsController < ApplicationController
  def create
    Post::Create.new.call(post_params) do |either|
      either.success { |post| render_json_oj({ post: post }) }
      either.failure { |errors| render_json_oj({ errors: errors }, status: 422) }
    end
  end

  def index
    render_json_oj({ posts: Post::TopRated.new(params[:count]).call }, except: [:id, :avg_rating])
  end

  private

  def post_params
    params.require(:post).permit(%i[
      author_ip login title content
    ])
  end
end
