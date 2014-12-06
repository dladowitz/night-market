module ApplicationHelper
  def bootstrap_datetime_format(ruby_datetime)
    datetime = ruby_datetime ? ruby_datetime : DateTime.now
    datetime.strftime("%m/%d/%Y %l:%M %p")
  end

end
