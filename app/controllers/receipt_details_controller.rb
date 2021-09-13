class ReceiptDetailsController < ApplicationController
  before_action :load_room, only: %i(create update_cart)

  def create
    row = ReceiptDetail.new receipt_detail_params
    row.into_money = sp_money(row.end_time, row.from_time)
    session[:cart].append row
    flash.now[:success] = t "cart.add_success"
  end

  def update_cart
    index = params[:index].to_i
    support_update session[:cart][index]
    flash[:success] = t "cart.update_success"
    redirect_to cart_path
  end

  def destroy_cart
    session[:cart].delete_at params[:index].to_i
    flash[:danger] = t "cart.delete_success"
    redirect_to cart_path
  end

  private

  def sp_money end_time, from_time
    total_time = (end_time.to_datetime.to_f - from_time.to_datetime.to_f)
    into_money((total_time / Settings.hour_1.hour).round(Settings.round_3))
  end

  def into_money  total_time
    if total_time < Settings.hour_in_day_20
      total_time * @room.hourly_price
    elsif total_time > Settings.hour_in_month_24_20
      (total_time / Settings.hour_in_month_24_20)
        .round(Settings.round_3) * @room.monthly_price
    else
      (total_time / Settings.hour_24).round(Settings.round_3) * @room.day_price
    end
  end

  def support_update row
    row["from_time"] = params[:from_time]
    row["end_time"] = params[:end_time]
    row["amount_of_people"] = params[:amount_of_people]
    row["into_money"] = sp_money(params[:end_time], params[:from_time])
  end

  def receipt_detail_params
    params.require(:receipt_detail).permit(:room_id, :from_time,
                                           :end_time, :amount_of_people)
  end

  def load_room
    room_id = params[:room_id] || params[:receipt_detail][:room_id]
    @room = Room.find_by id: room_id
    return if @room

    flash[:warning] = t "rooms.not_exist"
    redirect_to root_path
  end
end
