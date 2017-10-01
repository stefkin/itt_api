class Post::TopRated
  def initialize(count)
    @count = count
  end

  attr_reader :count

  def call
    Post.joins('LEFT JOIN ratings ON posts.id = ratings.post_id')
      .select('posts.title, posts.content, avg(ratings.value) as avg_rating')
      .group('posts.id')
      .order('avg_rating DESC')
      .limit(count)
  end
end
