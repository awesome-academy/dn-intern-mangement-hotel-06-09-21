module ReceiptsHelper
  def money_receipts
    session[:cart].sum {|i| i["into_money"].to_f}
  end

  def status_bill status
    case status
    when 0
      "Wait for confirmation"
    when 1
      "Approved"
    when 2
      "Complete"
    when 3
      "Cancelled"
    else
      "Unknown"
    end
  end
end
