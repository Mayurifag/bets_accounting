# frozen_string_literal: true

# Module with easy helpers to render json
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
