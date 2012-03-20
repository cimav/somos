class Membership < ActiveRecord::Base
  belongs_to :user;
  belongs_to :group;

  def can_publish?
    can_publish == 1
  end
end
