require_relative 'board.rb'
require_relative 'boardcase.rb'
require_relative 'game.rb'


class Player

  attr_reader :nom, :symbole

  def initialize(nom, symbole)
    @nom = nom
    @symbole = symbole if symbole.size == 1 # seuls symbole de 1 charactere sont acceptés (voir plus loin)
  end

  def jouer(i, j, board)
    board.changer_etat(@symbole, i, j) # la methode changer_etat de Board est ici utilisée
  end

end # fin de la classe Player
