module Api::V1
  class ApiController < ApplicationController
 

    alias_method :current_user, :current_api_v1_user
    alias_method :authenticate_user!, :authenticate_api_v1_user!

    before_action :require_authentication!
    before_action  :authenticate_user!

    
     
    private
     
    def require_authentication!
      throw(:warden, scope: :user) unless current_user.presence
    end
  
  end  
 end