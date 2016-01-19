module ApplicationHelper
  def friendly_date(d)
    d.strftime("%e %B %Y")
  end
  def friendly_date_compact(d)
    d.strftime("%e-%m-%Y")
  end
  def friendly_date_long(d)
    d.strftime("%e-%m-%Y %k:%M")
  end
end
