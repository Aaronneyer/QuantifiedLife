module DaysHelper
  def impact_class(day)
    case day.impact
    when (8..10) then 'high-impact'
    when (5..7) then 'medium-impact'
    when (2..4) then 'low-impact'
    else ''
    end
  end
end
