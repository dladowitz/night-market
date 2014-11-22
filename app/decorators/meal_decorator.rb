class MealDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def bootrap_datetime_format
    datetime = object.start ? object.start : DateTime.now
    datetime.strftime("%m/%d/%Y %l:%M %p")
  end
end
