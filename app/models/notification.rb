class Notification < ActiveRecord::Base
  belongs_to :user

  def to_js
    {title: self.title, content: self.content}
  end
end

#remove if using a polling solution with persistence ie. pubnub
#keep if using straight websockets for messaging