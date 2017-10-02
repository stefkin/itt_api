Post::Schema = Dry::Validation.Form do
  configure { config.type_specs = true }

  required(:login, Types::String).filled
  required(:author_ip, Types::String).filled
  required(:title, Types::String).filled
  required(:content, Types::String).filled
end
