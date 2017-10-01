class Post::AvgRating
  def initialize(id)
    @post_id = id
  end

  attr_reader :post_id

  def call
    Rating.where(post_id: post_id).average(:value)
  end
end
