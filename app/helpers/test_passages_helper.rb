module TestPassagesHelper
  def timer(test_passage)
    return "" unless test_passage.limited_in_time?
    content_tag :div do
      content_tag(:span, t(".time_left") << ": ") +
      content_tag(:span, "", class: "timer", data: { time_left: test_passage.time_left })
    end
  end
end
