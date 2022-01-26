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

  def vadmin?
    current_account&.role == 'vadmin' if account_signed_in?
  end

  def spinner(msg)
    "<div class='d-flex align-items-center'>
      <div class='spinner-border spinner-border-sm ms-auto me-3' role='status' aria-hidden='true'></div>
      #{msg}
    </div>"
  end


end
