require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'boardcase.rb'
require_relative 'game.rb'

def play_the_game
  puts "Choisissez la dimension du jeu !"
  dimension = gets.chomp.to_i
  puts "Quel est le nom du premier joueur?"
  name1 = gets.chomp
  puts "Quel est le symbole du premier joueur?"
  sym1 = gets.chomp
  puts "Quel est le nom du second joueur?"
  name2 = gets.chomp
  puts "Quel est le symbole du second joueur?"
  sym2 = gets.chomp
  player1 = Player.new(name1, sym1)
  player2 = Player.new(name2, sym2)
  players = [player1, player2]
  game = Game.new(dimension, players)
  puts game.afficher
  while(!game.est_finie[0]) do
    puts "Sur quel case #{player1.nom} souhaite t-il jouer ? (nombre entre 1 et #{dimension})"
    puts "Ligne numéro ?"
    print ">>"
    ligne = gets.chomp.to_i - 1
    puts "Colonne numéro ?"
    print ">>"
    colonne = gets.chomp.to_i - 1
    if game.board.case(ligne, colonne).afficher == "#"
      player1.jouer(ligne, colonne, game.board)
    else
      puts "Tu joues sur une case déjà jouée, tu ne peux pas !"
    end
    puts game.afficher
    break if game.est_finie[0]
    puts "Sur quel case #{player2.nom} souhaite t-il jouer ? (nombre entre 1 et #{dimension})"
    puts "Ligne numéro ?"
    print ">>"
    ligne = gets.chomp.to_i - 1
    puts "Colonne numéro ?"
    print ">>"
    colonne = gets.chomp.to_i - 1
    if game.board.case(ligne, colonne).afficher == "#"
      player2.jouer(ligne, colonne, game.board)
    else
      puts "Tu joues sur une case déjà jouée, tu ne peux pas !"
    end
    puts game.afficher
  end
  puts "Fin du game"
  puts "Le vainqueur est #{game.afficher_vainqueur}"
end

play_the_game
