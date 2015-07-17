class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :api_key

  # self.primary_key = "uuid"

  # attr_uuid :id, column_name: "uuid", autofill: true

  validates :email, presence: true
  validates :username, presence: true
  validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, 
    presence: true, uniqueness: true

  def self.register(params)
    @user = create!(permit_create_user(params))
    # tao folder voi ten cua user
    # SyncFile.create_user_folder(@user.username)
    @user
  end

  private
  
  def self.permit_create_user(params)
      params.permit(:email, :password, :username)
  end

end
