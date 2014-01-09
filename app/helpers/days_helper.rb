module DaysHelper
  def impact_class(day)
    case day.impact
    when (8..10) then 'high-impact'
    when (5..7) then 'medium-impact'
    when (2..4) then 'low-impact'
    else ''
    end
  end

  def activity_text(activity)
    "#{activity['activity']}'d #{number_with_delimiter activity['distance']} meters over #{readable_time(activity['duration'])}"
  end

  def readable_time(duration)
    distance_of_time_in_words(Time.at(duration), Time.at(0))
  end
end
