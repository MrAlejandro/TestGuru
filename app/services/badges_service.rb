class BadgesService
  def initialize(user)
    @user = user
  end

  def give_badges!(test_passage)
    return false unless test_passage.passed?

    Badge.all.each do |badge|
      if eligible_for_badge?(badge, test_passage)
        @user.badges << badge
      end
    end
    @user.save
  end

  private

  def eligible_for_badge?(badge, test_passage)
    meet_first_try_condition?(badge, test_passage) ||
      meet_category_condition?(badge, test_passage) ||
      meet_test_level_condition?(badge, test_passage)
  end

  def meet_first_try_condition?(badge, test_passage)
    return false if badge.first_try == false

    if must_pass_all_tests?(badge)
      passed_from_the_first_try?(test_passage) && other_tests_passed_from_the_first_try?(test_passage)
    else
      passed_from_the_first_try?(test_passage)
    end
  end

  def must_pass_all_tests?(badge)
    badge.all_tests?
  end

  def passed_from_the_first_try?(test_passage)
    @user
      .test_passages
      .for_tests(test_passage.test_id)
      .exclude(test_passage.id)
      .count == 0
  end

  def other_tests_passed_from_the_first_try?(test_passage)
    other_tests = @user
      .test_passages
      .exclude_tests(test_passage.test_id)

    other_passed_tests = other_tests.passed

    return false if other_tests.count != other_passed_tests.count

    other_tests_quantity = Test.all.exclude(test_passage.test_id)
    other_tests_quantity == other_tests.count
  end

  def meet_category_condition?(badge, test_passage)
    return false unless badge.category_id

    if must_pass_all_tests?(badge)
      passed_all_from_category?(badge.category_id)
    else
      test_passage.test.category.id == badge.category_id
    end
  end

  def passed_all_from_category?(category_id)
    test_ids = Test.by_category(category_id).pluck(:id)
    passed_test_ids = @user.test_passages.for_tests(test_ids).passed.pluck(:test_id)
    test_ids.count == passed_test_ids.count
  end

  def meet_test_level_condition?(badge, test_passage)
    return false unless badge.test_level.nil?

    if must_pass_all_tests?(badge)
      passed_all_with_level?(badge.test_level)
    else
      test_passage.test.level == badge.test_level
    end
  end

  def passed_all_with_level?(level)
    test_ids = Test.find_by_level(level).pluck(:id)
    passed_test_ids = @user.test_passages.for_tests(test_ids).passed.pluck(:test_id)
    test_ids.count == passed_test_ids.count
  end
end
