Rating::Schema = Dry::Validation.Form do
  configure { config.type_specs = true }

  required(:value, Types::Coercible::Int).filled(included_in?: (1..5))
  required(:post_id, Types::Coercible::Int).filled
end
