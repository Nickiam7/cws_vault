module ApplicationHelper
  def flash_class(key)
    case key
    when "success" then "alert alert-success"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-danger"
    when "notice" then "alert alert-success"
    end
  end

  def formatted_amount(amount)
    number_to_currency amount / 100.0
  end
end
