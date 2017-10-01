Post::Schema = Dry::Validation.Schema do
  required(:login).filled(min_size?: 3)
end
