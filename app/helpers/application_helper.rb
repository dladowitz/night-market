module ApplicationHelper

  #TODO look at side by side date/time pickers: http://jsfiddle.net/praveen_jegan/6FcBT/1/
  def bootstrap_datetime_format(ruby_datetime)
    datetime = ruby_datetime ? ruby_datetime : DateTime.now
    datetime.strftime("%m/%d/%Y %l:%M %p")
  end
end
