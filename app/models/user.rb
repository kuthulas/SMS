class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :checkins
  has_many :events, through: :checkins
  has_many :students, through: :checkins

  self.per_page = 10
end
