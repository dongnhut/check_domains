module V1
  class UserAPI < Grape::API
    resource :users do

      desc "Register user."
      post "/register", rabl: "users/show" do
        ActiveRecord::Base.transaction do
          @user = User.register(converted_params)
        end
      end

      desc "show current user."
      get "/", rabl: "users/show" do
        ActiveRecord::Base.transaction do
          authenticate!
        end
      end

    end
  end
end