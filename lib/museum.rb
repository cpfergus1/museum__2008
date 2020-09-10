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
end
