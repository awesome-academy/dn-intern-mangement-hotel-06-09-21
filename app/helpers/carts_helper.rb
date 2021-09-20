module CartsHelper
  def sp_money end_time, from_time
    total_time = end_time.to_datetime.to_f - from_time.to_datetime.to_f
    into_money(total_time / Settings.hour_1.hour).round Settings.round_3
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
end
