class Auth < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  self.table_name = "users"

  has_one :api_key, :foreign_key => "user_id"

  # self.primary_key = "uuid"

  # attr_uuid :id, column_name: "uuid", autofill: true

  validates :email, presence: true
  validates :username, presence: true
  validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, 
    presence: true, uniqueness: true

  def self.login(params)
    user = find_by(email: params[:email])
    fail ResourceNotFound unless user.present?
    fail Unauthorized unless user.valid_password?(params[:password].to_s)
    user.api_key.present? ? user.api_key.set_expiration : ApiKey.create!(user_id: user.id)
    user.reload
  end

  def self.logout(user)
    user.api_key.destroy!
    user
  end
  
end
