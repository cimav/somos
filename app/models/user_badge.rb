class UserBadge < ActiveRecord::Base
  belongs_to :user;
  belongs_to :badge;
  belongs_to :post;
end
