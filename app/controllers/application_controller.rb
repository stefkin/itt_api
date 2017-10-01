class ApplicationController < ActionController::API

  # NOTE: Oj.mimic_JSON doesn't work for some reason in current version
  def render_json_oj(object, status: 200, **params)
    defaults = { mode: :compat, use_as_json: true }
    render json: Oj.dump(object, defaults.merge(params))
  end
end
