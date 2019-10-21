#création de la class gossip avec une méthode save

require 'csv'

class Gossip

	attr_accessor :author , :content

  def initialize(author, content)
  	@author = author
  	@content = content
  end

#enregistrer les potins dans le fichier CSV
  def save
  	CSV.open("./db/gossip.csv", "ab") do |csv|
  		csv << [@author, @content]
  	end 
  end

#afficher toutes les données de la class Gossip
  def self.all 
  	all_gossips = [] #on initialise un array vide
 #on va chercher chacune des lignes du CSV do
 #on va crée un gossip avec les infos de la ligne
 #all_gossip << gossip (on rajoute le gossip à l'array)
   	CSV.read("./db/gossip.csv").each do |csv_line|
   		all_gossips << Gossip.new(csv_line[0], csv_line[1]) 
   	end 
  return all_gossips
  end 

  #on récupére le gossip numéro id
  def self.find(id)
    puts Gossip.all
    all_gossips = Gossip.all
    return all_gossips[id.to_i]
  end


#updater un gossip en modifiant son auteur et son contenu
  def self.update(author, content, id)
      new_array = Gossip.all

      #delete all the file in the CSV file
      File.open("./db/gossip.csv", 'w') {|file| file.truncate(0) }
      new_array[id.to_i].author = author
      new_array[id.to_i].content = content

      
      #put new informations inside the array
        new_array.each do |gossip|
        gossip.save
        end
        
      end 

  end
