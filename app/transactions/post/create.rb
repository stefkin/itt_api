class Post::Create
  include Dry::Transaction

  step :validate
  step :persist

  def validate(input)
    result = Post::Schema.call(input.to_h)
    result.success? ? Right(result.output) : Left(result.errors)
  end

  def persist(input)
    user = User.find_or_initialize_by(login: input[:login])
    post = Post.new(input.except(:login).merge(user: user))

    post.save ? Right(post) : Left(post.errors.full_messages)
  end
end
