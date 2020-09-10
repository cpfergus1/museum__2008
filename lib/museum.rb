require_relative 'patron'
require_relative 'exhibit'

class Museum

  attr_reader :name, :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  
end
