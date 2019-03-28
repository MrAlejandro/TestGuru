class BadgesService
  def initialize(user)
    @user = user
  end

  def give_badges!(test_passage)
    return false unless test_passage.passed?

    Badge.all.each do |badge|
      if send "#{badge.rule_name}_award?", test_passage
        @user.badges << badge
      end
    end
    @user.save
  end

  private

  def category_award?(test_passage)
    passed_all_from_category?(test_passage.test.category_id)
  end

  def passed_all_from_category?(category_id)
    test_ids = Test.by_category(category_id).pluck(:id)
    passed_test_ids = @user.test_passages.for_tests(test_ids).passed.pluck(:test_id)
    test_ids.count == passed_test_ids.count
  end

  def attempt_award?(test_passage)
    passed_from_the_first_try?(test_passage)
  end

  def passed_from_the_first_try?(test_passage)
    @user
      .test_passages
      .for_tests(test_passage.test_id)
      .exclude(test_passage.id)
      .count == 0
  end

  def level_award?(test_passage)
    passed_all_with_level?(test_passage.test.level)
  end

  def passed_all_with_level?(level)
    binding.irb
    test_ids = Test.by_level(level).pluck(:id)
    passed_test_ids = @user.test_passages.for_tests(test_ids).passed.distinct.pluck(:test_id)
    test_ids.count == passed_test_ids.count
  end
end
