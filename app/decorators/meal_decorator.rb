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

  def bootstrap_datetime_format
    datetime = object.start ? object.start : DateTime.now
    datetime.strftime("%m/%d/%Y %l:%M %p")
  end

  def short_start_date
    if meal.start
      "#{meal.start.strftime("%a, %b")} #{meal.start.strftime("%-d").to_i.ordinalize}"
    else
      "Missing Date"
    end
  end

  def percentage_of_budget
    if meal.percent_of_budget
      "#{meal.percent_of_budget.round}% of event budget"
    else
      "Missing Meal Cost or Event Budget"
    end
  end
end
