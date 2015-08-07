module V1
  class AuthAPI < Grape::API
    resource :auth do
      
      desc "user login."
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post "/login", rabl: "auths/show" do
        ActiveRecord::Base.transaction do
          @auth = Auth.login(converted_params)
        end
      end

      desc "user logout.",{
        headers: {
          "Access-Token" => { description: "Access-Token", required: true }
        }
      }
      get "/logout", rabl: "users/show" do
        ActiveRecord::Base.transaction do
          @auth = Auth.logout(current_user)
        end
      end

    end
  end
end