module BadgesHelper
  def conditions(badge)
    condition = quantity_condition(badge)
    condition << category_condition(badge)
    condition << level_condition(badge)
    condition << first_time_condition(badge)
    condition
  end

  def avail_categories
    Category.all
  end

  def avail_test_levels
    TestsHelper::TEST_LEVELS
  end

  private

  def quantity_condition(badge)
    t(".quantity_condition", condition: t(".#{badge.quantity_condition}"))
  end

  def category_condition(badge)
    if badge.category
      "<br/>" << t(".from_category", title: badge.category.title)
    else
      ""
    end
  end

  def level_condition(badge)
    if badge.test_level
      "<br/>" << t(".with_test_level", level: test_level(badge.test_level))
    else
      ""
    end
  end

  def first_time_condition(badge)
    if badge.first_try
      "<br/>" << t(".from_the_first_try")
    else
      ""
    end
  end
end
