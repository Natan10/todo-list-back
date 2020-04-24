class Api::V1::SessionController < Api::V1::ApiController

  def login 
    render json: { login: 'ok' }
  end

end
