class RecipeTypeController < ApplicationController

    #write a custom route '/recipe_types/most_popular' that a user can visit to see the most recipe type with the most recipes associated with it
    #HINT: max_by  ruby Array method to help you find the recipe type with the most recipes 


    get '/recipe_types/most_popular' do
        @recipeTypes=RecipeType.all
        @most_recipe=@recipeTypes.max_by { |x| x.recipes.count}
        erb :'recipe_types/most_popular'
    end



end