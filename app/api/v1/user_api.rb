module V1
  class UserAPI < Grape::API
    resource :users do

      desc "Register user."
      params do
        # requires :action, type: Symbol, values: [:PAUSE, :RESUME, :STOP], documentation: { param_type: 'query' }
        requires :email, type: String
        requires :password, type: String
        requires :username, type: String
      end
      post "/register", rabl: "users/show" do
        ActiveRecord::Base.transaction do
          @user = User.register(converted_params)
        end
      end

      desc "show current user.",{
        headers: {
          "Access-Token" => { description: "Access-Token", required: true }
        }
      }
      get "/", rabl: "users/show" do
        ActiveRecord::Base.transaction do
          authenticate!
        end
      end

    end
  end
end