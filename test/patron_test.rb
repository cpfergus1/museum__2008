require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'

class PatronTest <Minitest::Test

  def setup
    @patron_1 = Patron.new("Bob", 20)
  end

  def test_patron_has_attributes
    assert_equal 'Bob',@patron_1.name
    assert_equal [], @patron_1.interests
    assert_equal 20, @patron_1.spending_money
  end

  def test_can_add_patron_interests
    @patron_1.add_interest("Dead Sea Scrolls")
    @patron_1.add_interest("Gems and Minerals")
    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"],@patron_1.interests
  end
end
