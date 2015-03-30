class User < ActiveRecord::Base
  has_many :sends, :class_name => 'Transfer', :foreign_key => 'sender_id'
  has_many :receives, :class_name => 'Transfer', :foreign_key => 'receiver_id'
end
