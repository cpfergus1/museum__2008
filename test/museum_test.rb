require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'
require './lib/patron'
require './lib/exhibit'

class MuseumTest <Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
  end

  def test_museum_has_attributes
    assert_equal "Denver Museum of Nature and Science" , @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_can_add_museum_exhibits
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    @dmns.add_exhibit(gems_and_minerals)
    @dmns.add_exhibit(dead_sea_scrolls)
    @dmns.add_exhibit(imax)
    assert_equal [gems_and_minerals, dead_sea_scrolls, imax], @dmns.exhibits
  end

  def test_meseum_can_recommend_exhibits
    skip
    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("IMAX")
    assert_equal [dead_sea_scrolls, gems_and_minerals], @dmns.recommend_exhibits(patron_1)
    assert_equal [imax], @dmns.recommend_exhibits(patron_2)
  end

end
