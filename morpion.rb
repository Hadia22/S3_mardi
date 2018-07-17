class Board

  attr_accessor :dimension, :boardcases

  def initialize(dimension)
    @dimension = dimension
    @boardcases = []
    for i in 0...dimension
      bbboard = []
      for j in 0...dimension
        bbboard << BoardCase.new(i,j)
      end
      @boardcases << bbboard
    end
  end

  def afficher
    table = []
    for i in 0...@dimension
      table << @boardcases[i].map { |e| e.afficher }.join(' ')
    end
    return table
  end

  def changer_etat(nouvel_etat, i, j)
    @boardcases[i][j].changer_etat(nouvel_etat)
  end

  def case(i,j)
    return @boardcases[i][j]
  end

end # fin de Board


class BoardCase

  def initialize(ligne, colonne)
    @etat = '#'
    @ligne = ligne
    @colonne = colonne
  end

  def afficher
    @etat
  end

  def changer_etat(nouvel_etat)
    @etat = nouvel_etat
  end

end # fin de la classe BoardCase



class Player

  attr_reader :nom, :avatar

  def initialize(nom, avatar)
    @nom = nom
    @avatar = avatar if avatar.size == 1
  end

  def jouer(i, j, board)
    board.changer_etat(@avatar, i, j)
  end

end # fin de la classe Player



class Game

  attr_accessor :board

  def initialize(dimension, players = [])
    @board = Board.new(dimension)
    @players = players
  end

  def est_finie
    for i in 0...@board.dimension # on test les colonnes
        a = 0
        x = @board.case(i,0).afficher
        for j in 1...@board.dimension
          a +=1 if x != @board.case(i,j).afficher
        end
        return [true, x] if a==0 && x!="#"
    end

    for j in 0...@board.dimension # on test les lignes
        a = 0
        x = @board.case(0,j).afficher
        for i in 1...@board.dimension
          a +=1 if x != @board.case(i,j).afficher
        end
        return [true, x] if a==0 && x!="#"
    end

    a = 0
    x = @board.case(0,0).afficher
    for i in 0...@board.dimension
      a += 1 if x != @board.case(i,i).afficher
    end
    return [true, x] if a==0 && x!="#"

    a = 0
    x = @board.case(0,@board.dimension-1).afficher
    for i in 0...@board.dimension
      a += 1 if x != @board.boardcases[i][@board.dimension-1-i].afficher
    end
    return [true, x] if a==0 && x!="#"

    a = 0
    for i in 0...@board.dimension
      for j in 0...@board.dimension
        a+=1 if @board.boardcases[i][j].afficher == "#"
      end
    end
    return [true, nil] if a == 0

    return [false, nil]
  end

  def afficher_vainqueur
    sym = self.est_finie[1]
    @players.each{ |p| return p.nom if sym == p.avatar}
  end

  def afficher
    @board.afficher
  end

end # fin de la classe Game



def play_the_game
  puts "Choisissez la dimension du jeu !"
  dimension = gets.chomp.to_i
  puts "Nom du premier joueur?"
  name1 = gets.chomp
  puts "Symbole du premier joueur?"
  sym1 = gets.chomp
  puts "Nom du second joueur?"
  name2 = gets.chomp
  puts "Symbole du second joueur?"
  sym2 = gets.chomp
  player1 = Player.new(name1, sym1)
  player2 = Player.new(name2, sym2)
  players = [player1, player2]
  game = Game.new(dimension, players)
  puts game.est_finie[0]
  while(!game.est_finie[0]) do
    puts "Joueur 1?"
    puts "Ligne?"
    ligne = gets.chomp.to_i
    puts "colonne?"
    colonne = gets.chomp.to_i
    player1.jouer(ligne, colonne, game.board)
    puts game.afficher
    puts game.est_finie.inspect
    break if game.est_finie[0]
    puts "Joueur 2?"
    puts "Ligne?"
    ligne = gets.chomp.to_i
    puts "colonne?"
    colonne = gets.chomp.to_i
    player2.jouer(ligne, colonne, game.board)
    puts game.afficher
    puts game.est_finie.inspect
  end

  puts "fin du game"
  puts "Le vainqueur est "
  puts game.afficher_vainqueur
end

play_the_game
