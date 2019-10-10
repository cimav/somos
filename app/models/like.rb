class Like < ActiveRecord::Base
  # attr_accessible :user_id
  belongs_to :attachable, :polymorphic => true
  belongs_to :user
end
