require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/museum'
require './lib/patron'
require './lib/exhibit'

class MuseumTest <Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @imax = Exhibit.new({name: "IMAX",cost: 15})
    @patron_1 = Patron.new("Bob", 0)
    @patron_2 = Patron.new("Sally", 20)
    @patron_3 = Patron.new("Johnny", 5)
    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)
    @patron_1.add_interest("Gems and Minerals")
    @patron_2.add_interest("Dead Sea Scrolls")
    @patron_3.add_interest("Dead Sea Scrolls")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
  end

  def test_museum_has_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")
    assert_equal "Denver Museum of Nature and Science" , dmns.name
    assert_equal [], dmns.exhibits
  end

  def test_museum_can_admit_patron
    dmns = Museum.new("Denver Museum of Nature and Science")
    patron_1 = Patron.new("Bob", 0)
    patron_2 = Patron.new("jim", 20)
    dmns.admit(patron_1)
    dmns.admit(patron_2)
    assert_equal [patron_1, patron_2], dmns.patrons
  end

  def test_can_add_museum_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)
    assert_equal [gems_and_minerals, dead_sea_scrolls, imax], dmns.exhibits
  end

  def test_meseum_can_recommend_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit(@dead_sea_scrolls)
    dmns.add_exhibit(@gems_and_minerals)
    dmns.add_exhibit(@imax)
    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("IMAX")
    assert_equal [@dead_sea_scrolls, @gems_and_minerals], dmns.recommend_exhibits(patron_1)
    assert_equal [@imax], @dmns.recommend_exhibits(patron_2)
  end

  def test_patrons_by_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    expected = {@gems_and_minerals => [@patron_1],
                @dead_sea_scrolls => [@patron_2, @patron_3],
                @imax => []}
    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end

  def test_ticket_lottery_contestants
    dmns = Museum.new("Denver Museum of Nature and Science")
    patron_1 = Patron.new("Bob", 0)
    patron_2 = Patron.new("Sally", 5)
    patron_3 = Patron.new("Johnny", 5)
    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3.add_interest("Dead Sea Scrolls")
    dmns.add_exhibit(@gems_and_minerals)
    dmns.add_exhibit(@dead_sea_scrolls)
    dmns.add_exhibit(@imax)
    expected = [patron_2, patron_3], dmns.ticket_lottery_contestants(@dead_sea_scrolls)
  end

  def test_draw_lotter_winner
    dmns = Museum.new("Denver Museum of Nature and Science")
    patron_1 = Patron.new("Bob", 0)
    patron_2 = Patron.new("Sally", 5)
    patron_3 = Patron.new("Johnny", 5)
    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3.add_interest("Dead Sea Scrolls")
    dmns.add_exhibit(@dead_sea_scrolls)
    dmns.stubs(:sample).returns(patron_3)
    assert_equal patron_3, dmns.draw_lottery_winner(@dead_sea_scrolls)

  end

end
