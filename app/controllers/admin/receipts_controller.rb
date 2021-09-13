class Admin::ReceiptsController < Admin::AdminsController

  def index
    @receipts = Receipt.where user_id: current_user
  end  
end
