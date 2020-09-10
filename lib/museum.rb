require_relative 'patron'
require_relative 'exhibit'

class Museum

  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def admit(patron)
    @patrons << patron
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.map do |exhibit|
      if patron.interests.include? exhibit.name
        exhibit
      end
    end.reject(&:nil?)
  end

  def patrons_by_exhibit_interest
    interest = {}
    @exhibits.each do |exhibit|
      interest[exhibit] = @patrons.find_all do |patron|
        patron.interests.include? exhibit.name
      end
    end
    interest
  end

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit].map do |patron|
      if patron.spending_money <= exhibit.cost
        patron
      end
    end.reject(&:nil?)
  end

  def draw_lottery_winner(exhibit)
    ticket_lottery_contestants(exhibit).sample
  end

  def announce_lotter_winner(exhibit)
    name = draw_lottery_winner(exhibit)
    puts "#{name} has won the #{exhibit.name} edhibit lottery"
  end

end
