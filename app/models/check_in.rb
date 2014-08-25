class CheckIn < ActiveRecord::Base
  include CheckInsHelper #8/25/14 - models and controllers should not use helpers, use service object?

	belongs_to :user
	belongs_to :location

  before_create :set_defaults
  after_create :check_in_xp #in helpers/check_ins_helper.rb

  def set_defaults
    self.xp ||= 0
  end


end
