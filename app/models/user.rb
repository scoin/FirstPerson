class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable
  include UsersHelper #no helpers in models or controllers, service object?

  has_many :created_quests, class_name: 'Quest', foreign_key: 'creator_id' #alias
  has_many :user_quests
  has_many :quests, through: :user_quests
  has_many :user_rewards
  has_many :rewards, through: :user_rewards
  has_many :user_checkpoints
  has_many :checkpoints, through: :user_checkpoints
  has_many :check_ins
  has_many :locations, through: :check_ins
  has_many :notifications

  before_create :set_defaults

  def completed_quests #move this into a scope under completed quests
    self.user_quests.select{|quest| quest.completed == true}
  end

  def self.sort_users
    #this is for the xp leaderboard, rename to something more descriptive like self.top_exp
     @users = User.order(:total_xp).reverse.take(10)
  end

  def set_defaults
    self.total_xp ||= 0
    self.photo_url = "http://www.infragistics.com/media/8948/anonymous_200.gif" #should be ||=
  end

end
