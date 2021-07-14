module ApplicationHelper
  def flash_class(key)
    case key
    when "success" then "alert alert-success"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-danger"
    when "notice" then "alert alert-success"
    end
  end
end
