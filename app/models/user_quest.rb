class UserQuest < ActiveRecord::Base
  belongs_to :quest
  belongs_to :user

  # after_create :create_related_checkpoints

  def complete!
    unless self.completed
      self.update(completed: true)
      earned_xp = self.quest.xp
      self.user.total_xp += earned_xp
      self.user.save!
    end
  end

  def create_related_checkpoints #appears to be an artifact, delete
    self.quest.checkpoints
  end
  
end

