class Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  after_create :check_short_name
  after_update :check_short_name

  def check_short_name
    if Page.where(:group_id => self.group_id, :short_name => self.short_name).count > 1
      self.short_name = "#{self.short_name}-#{self.id}"
      self.save
    end
  end
end
