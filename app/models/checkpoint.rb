class Checkpoint < ActiveRecord::Base
  belongs_to :location
  belongs_to :quest
  has_many :user_checkpoints
  has_many :users, through: :user_checkpoints
end

#8/25/14 - maybe add some validations to this file?
