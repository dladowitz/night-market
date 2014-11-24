class DishDecorator < Draper::Decorator
  delegate_all

  VALID_WARNING_TYPES = [:servings, :transport, :order]

  def show_warning?(warning_type)
    raise "Invalid 'warning_type'" unless VALID_WARNING_TYPES.include?(warning_type)

    return false if meal.ignore_warnings

    case warning_type
    when :servings
      servings_warning?
    when :transport
      transport_warning?
    when :order
      order_warning?
    end
  end


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
