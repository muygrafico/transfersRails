class Transfer < ActiveRecord::Base
  after_save :balance_on_create
  after_destroy :balance_on_destroy
  after_update :balance_on_update

  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  private

  def balance_on_create
    update_balance(:on_create)
  end

  def balance_on_destroy
    update_balance(:on_destroy)
  end

  def balance_on_update
    update_balance(:on_update)
  end

  def update_balance(on_action)
    #cb Stand for Current Balance

    sender_cb = self.sender.balance
    reciever_cb = self.receiver.balance

    sender = User.find_by_id(self.sender.id)
    reciever = User.find_by_id(self.receiver.id)

    case on_action
      when :on_create

        balance_sender = sender_cb - amount
        balance_reciever = reciever_cb + amount
        sender.update_attributes(balance: balance_sender )
        reciever.update_attributes(balance: balance_reciever )

      when :on_destroy

        balance_sender = sender_cb + amount
        balance_reciever = reciever_cb - amount
        sender.update_attributes(balance: balance_sender )
        reciever.update_attributes(balance: balance_reciever )

      when :on_update

        balance_sender = sender_cb + amount
        balance_reciever = reciever_cb - amount
        sender.update_attributes(balance: balance_sender )
        reciever.update_attributes(balance: balance_reciever )

        balance_sender = sender_cb - amount
        balance_reciever = reciever_cb + amount
        sender.update_attributes(balance: balance_sender )
        reciever.update_attributes(balance: balance_reciever )
    end

 end

end
