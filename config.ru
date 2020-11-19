require './config/environment'

use Rack::MethodOverride
use RecipesController
use UsersController
use RecipeTypeController
run ApplicationController
