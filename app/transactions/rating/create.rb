class Rating::Create
  include Dry::Transaction

  step :validate
  step :persist

  def validate(input)
    result = Rating::Schema.call(input.permit!.to_h)
    result.success? ? Right(result.output) : Left(result.errors)
  end

  def persist(input)
    rating = Rating.new(input)
    rating.save ? Right(rating) : Left(rating.errors.full_messages)
  end
end
