require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'boardcase.rb'


class Game

  attr_accessor :board

  def initialize(dimension, players = []) # une partie c'est un plateau de jeu et des joueurs, rien de plus !
    @board = Board.new(dimension)
    @players = players
  end

  def est_finie # un peu lourd, mais il faut bien tester en dimension quelconque ...
    for i in 0...@board.dimension # on teste les lignes
        a = 0
        x = @board.case(i,0).afficher
        for j in 1...@board.dimension
          a +=1 if x != @board.case(i,j).afficher
        end
        return [true, x] if a==0 && x!="#"
    end

    for j in 0...@board.dimension # on teste les colonnes
        a = 0
        x = @board.case(0,j).afficher
        for i in 1...@board.dimension
          a +=1 if x != @board.case(i,j).afficher
        end
        return [true, x] if a==0 && x!="#"
    end

    a = 0 # on teste la diagonale
    x = @board.case(0,0).afficher
    for i in 0...@board.dimension
      a += 1 if x != @board.case(i,i).afficher
    end
    return [true, x] if a==0 && x!="#"

    a = 0 # on teste la diagonale inverse
    x = @board.case(0,@board.dimension-1).afficher
    for i in 0...@board.dimension
      a += 1 if x != @board.case(i,@board.dimension-1-i).afficher
    end
    return [true, x] if a==0 && x!="#"

    a = 0
    for i in 0...@board.dimension
      for j in 0...@board.dimension
        a+=1 if @board.case(i,j).afficher == "#"
      end
    end
    return [true, nil] if a == 0

    return [false, nil]
  end

  def afficher_vainqueur
    sym = self.est_finie[1]
    return "pas de victoire, c'est une égalité parfaite" if sym == nil
    @players.each{ |p| return p.nom if sym == p.symbole}
  end

  def afficher
    @board.afficher
  end


end
