require 'sinatra/flash'

class RecipesController < ApplicationController
    register Sinatra::Flash

    get '/recipes' do
        @recipes=Recipe.all
        @recipeType=RecipeType.all
        erb :"recipes/index"
    end

    get '/recipes/random' do 
        @recipe=Recipe.all.sample
        @ingredients=bullet_list(@recipe.ingredients).reject{|i| i==""}
        @steps=bullet_list(@recipe.steps).reject{|i| i==""}
        erb :random
      end

    get '/recipes/example' do
        erb :'recipes/example'
    end

    get '/recipes/new' do
        @recipeType=RecipeType.all
        erb :'recipes/new'
    end

    post '/recipes' do
    
        valid=params[:recipe].map do |k,v|
            something_there(v)
         end
        
         if !valid.include?(false) && valid.count==6
            if valid_bullets(params[:recipe][:ingredients])&& valid_bullets(params[:recipe][:steps])
                recipe=Recipe.create(params[:recipe])
                redirect :"recipes/#{recipe.id}"
            else
                flash[:message]="Make sure to include * for each bullets in Ingredients and Steps"
                redirect to('/recipes/new')
            end
        else
            flash[:message]="Please fill out all fields"
            redirect to('/recipes/new')
        end

        #this is if we want to save what they inputed in the new form and put it back to the new form
        # params[:recipe].each do |k,v|
            # if v==""  
              # params[:recipe][k]="blank"
             #end  
        #end  


        #to make it fill in with info that was typed before. 
        #take the params info and fill it up with everything needed thats missing
        #I have to create a new recipe
        #put value in form set to the new temp recipe
    
        #in form I can have it check for a temp recipe by user id with if statment


    end

    get '/recipes/:id/cookmode' do
        @recipe=Recipe.find_by(id: params[:id])
        @ingredients=bullet_list(@recipe.ingredients).reject{|i| i==""}
        @steps=bullet_list(@recipe.steps).reject{|i| i==""}
        erb :'recipes/cookmode'
    end

    get '/recipes/:id/edit' do
        @recipe=Recipe.find_by(id: params[:id])
        @recipeType=RecipeType.all
        erb :'recipes/edit'
    end

    patch '/recipes/:id' do

        valid=params[:recipe].map do |k,v|
            something_there(v)
         end

         if !valid.include?(false) && valid.count==6
            if valid_bullets(params[:recipe][:ingredients])&& valid_bullets(params[:recipe][:steps])
                recipe=Recipe.find_by(id: params[:id])
                recipe.update(params[:recipe])
                flash[:message]="Recipe Edited!"

                redirect "recipes/#{recipe.id}"
                    else
                flash[:message]="Make sure to include * for each bullets in Ingredients and Steps"
                redirect to("recipes/#{params[:id]}/edit")
            end
        else
            flash[:message]="Please fill out all fields"
            redirect to("recipes/#{params[:id]}/edit")
        end
        # recipe=Recipe.find_by(id: params[:id])
        # recipe.update(params[:recipe])
        # redirect "recipes/#{recipe.id}"
    end

    delete '/recipes/:id' do
        recipe=Recipe.find_by(id: params[:id])
        recipe.destroy
        flash[:message]="recipe deleted"
        redirect '/recipes'
    end

    get '/recipes/:id' do
        @recipe=Recipe.find_by(id: params[:id])
        @ingredients=bullet_list(@recipe.ingredients).reject{|i| i==""}
        @steps=bullet_list(@recipe.steps).reject{|i| i==""}
        erb :"recipes/show"
    end 

   

end