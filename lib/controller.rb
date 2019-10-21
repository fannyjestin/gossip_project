require 'bundler'
Bundler.require

require 'gossip'

class ApplicationController < Sinatra::Base
#class ApplicationController hérite de la class Sinatra::Base
#grâce à cette héritage, l'application aura toutes les fonctionnalités de Sinatra


	get '/' do    
	  erb :index, locals: {gossips: Gossip.all}
#pas besoin de dire dans quel dossier il se trouve views
#la méthode locals permet d'envoyer à notre fichier ERB des variables
	end

#run! if app_file == $0 
#Cette ligne permet d'exécuter le code de la classe 
#sans avoir à écriire ApplicationController.new.perform
#mais le mieux c'est de bien séparer code et mettre les exécutions 
#dans un fichier à part, config.ru qui contient les infos nécessaires
#au lancement de notre serveur 

	get '/gossips/new/' do 
		erb :new_gossip
	end

	post '/gossips/new/' do  
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect '/'
	end 
#redirect : signifie maintenant redirige le user vers cette route


	get '/gossips/:id/' do 
		erb :show, locals: {gossips: Gossip.all[params[:id].to_i], id: params[:id].to_i}
	end

	#page de modification des données
	get '/gossips/:id/edit' do  
		erb :edit, locals: {gossips: Gossip.all[params[:id].to_i], id: params[:id].to_i}
	end 

	post '/gossips/:id/edit' do  
		puts "coucou"
		Gossip.update(params["gossip_author"], params["gossip_content"], params[:id].to_i)
		redirect '/'
	end 

end 

