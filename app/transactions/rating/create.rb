class Rating::Create
  include Dry::Transaction

  step :validate
  step :persist

  def validate(input)
    result = Rating::Schema.call(input.to_h)
    result.success? ? Right(result.output) : Left(result.errors)
  end

  def persist(input)
    ActiveRecord::Base.transaction do
      rating = Rating.new(input)
      if rating.save
        new_avg = Post::AvgRating.new(rating.post_id).call
        Post.where(id: rating.post_id).update_all(avg_rating: new_avg)
        Right(new_avg)
      else
        Left(rating.errors.full_messages)
      end
    end
  end
end
