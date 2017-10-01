class Post::TopRated
  def initialize(count)
    @count = count
  end

  attr_reader :count

  def call
    Post.select(:title, :content).order('avg_rating DESC').limit(count)
  end
end
