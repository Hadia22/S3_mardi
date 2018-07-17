require_relative 'player.rb'
require_relative 'boardcase.rb'
require_relative 'game.rb'

class Board

  attr_reader :dimension

  def initialize(dimension)
    @dimension = dimension # @dimension est la dimension du plateau de jeu (3x3 pour un morpion classique)
    @boardcases = []  # @boardcases est un tableau de tableau, que l'on pourra interpreter comme une matrice
    for i in 0...dimension
      bbboard = []
      for j in 0...dimension
        bbboard << BoardCase.new(i,j) # On crée les lignes une à une
      end
      @boardcases << bbboard # puis on les ajoute à notre @boardcases
    end
  end

  def afficher
    table = []
    for i in 0...@dimension
      table << @boardcases[i].map { |e| e.afficher }.join(' ') # une petite manipulation pour faire apparaitre cela joliment
    end
    return table
  end

  def changer_etat(nouvel_etat, i, j)
    @boardcases[i][j].changer_etat(nouvel_etat) # On utilise ici la methode changer_etat() de la classe BoardCase
  end

  def case(i,j) # permet une synthaxe plus légère dans les autres classes
    return @boardcases[i][j]
  end

end # fin de Board
