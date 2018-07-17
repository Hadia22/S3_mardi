require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'game.rb'

class BoardCase

  def initialize(ligne, colonne) # une boardCase a des coordonnées et un état
    @etat = '#' # L'état nul est "#"
    @ligne = ligne
    @colonne = colonne
  end

  def afficher
    @etat
  end

  def changer_etat(nouvel_etat)
    @etat = nouvel_etat
  end

end
