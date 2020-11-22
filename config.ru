require './config/environment'

use Rack::MethodOverride

run ApplicationController

use RecipesController
use UsersController
use RecipeTypeController
