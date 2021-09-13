class ReceiptsController < ApplicationController
  include ReceiptsHelper
  before_action :store_location, :logged_in_user

  def index
    @receipts = Receipt.where user_id: current_user
  end

  def show
    @receipt = Receipt.find_by id: params[:id]
    @receipt_details = @receipt.receipt_details
  end

  def create
    ActiveRecord::Base.transaction do
      @receipt = current_user.receipts.build
      build_cart_detail
      @receipt.payment = "TP bank"
      @receipt.into_money = money_receipts
      @receipt.paid = money_receipts
      @receipt.paid_at = DateTime.now
      @receipt.save!
      session[:cart] = []
    end
    flash[:success] = t "receipt.booking_successful"
    redirect_to @receipt
  rescue
    flash[:danger] = t "receipt.booking_fail"
    redirect_to root_path
  end

  private

  def build_cart_detail 
    session[:cart].each_with_index do |room, index|
      item = {room_id: room["room_id"],
              from_time: room["from_time"],
              end_time: room["end_time"],
              amount_of_people: room["amount_of_people"],
              into_money: room["into_money"]}
      @receipt.receipt_details.build item
    end
  end
end
