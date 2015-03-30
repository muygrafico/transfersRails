class Transfer < ActiveRecord::Base
  after_save :update_balance

  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  private

  def update_balance
    #cb Stand for Current Balance

    sender_cb = self.sender.balance
    reciever_cb = self.receiver.balance

    User.find_by_id(self.sender.id).update_attributes(balance: sender_cb - amount)
    User.find_by_id(self.receiver.id).update_attributes(balance: reciever_cb + amount)
  end

end

