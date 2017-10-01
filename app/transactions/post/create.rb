class Post::Create
  include Dry::Transaction

  step :validate
  step :persist

  def validate(input)
    result = Post::Schema.call(input)
    result.success? ? Right(input) : Left(result.errors)
  end

  def persist(input)
    user = User.find_or_initialize_by(login: input[:login])
    post = Post.new(input.except(:login).merge(user: user))

    post.save ? Right(post) : Left(post.errors.full_messages)
  end
end
