class Transfer < ActiveRecord::Base
  after_save :change_balance_on_create
  after_destroy :change_balance_on_destroy
  after_update :change_balance_on_update
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  private
  def change_balance_on_create
    change_balance(:on_create)
  end
  def change_balance_on_destroy
    change_balance(:on_destroy)
  end
  def change_balance_on_update
    change_balance(:on_update)
  end
  def update_balance(balance_sender, balance_reciever)
    sender = User.find_by_id(self.sender.id)
    reciever = User.find_by_id(self.receiver.id)
    sender.update_attributes(balance: balance_sender )
    receiver.update_attributes(balance: balance_reciever )
  end
  def change_balance(on_action)
    #cb Stand for Current Balance
    sender_cb = self.sender.balance
    reciever_cb = self.receiver.balance
    case on_action
      when :on_create
      update_balance(sender_cb - amount, reciever_cb + amount)
      when :on_destroy
      update_balance(sender_cb + amount,reciever_cb - amount)
      when :on_update
      update_balance(sender_cb + amount,reciever_cb - amount)
      update_balance( sender_cb - amount, reciever_cb + amount)
      end
  end
end
