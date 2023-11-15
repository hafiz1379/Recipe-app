class RecipesController < ApplicationController
    before_action :authenticate_user! # Ensure user is signed in for all actions
    before_action :authorize_user, only: [:destroy]
    
    # GET /recipes
    def index
        @user_recipes = current_user.recipes.all
        @public_recipes = Recipe.where(public: true).where.not(user_id: current_user.id)
        @recipes = @user_recipes + @public_recipes
    end
  
    # GET /recipes/new
    def new
      @recipe = Recipe.new
    end
  
    # POST /recipes
    def create
      @recipe = current_user.recipes.new(recipe_params)
      if @recipe.save
        redirect_to @recipe, notice: 'Recipe was successfully created.'
      else
        render :new
      end
    end
  
    # GET /recipes/:id
    def show
        @recipe = Recipe.find(params[:id])
        unless current_user == @recipe.user || @recipe.public
          redirect_to recipes_path, alert: 'Access denied.'
        end
    end
  
    # DELETE /recipes/:id
    def destroy
      recipe = current_user.recipes.find_by(id: params[:id])
      if recipe
        if recipe.destroy
          flash[:notice] = 'The Recipe has been deleted successfully!'
        else
          flash[:alert] = 'Delete Unsuccessful!'
        end
      else
        flash[:alert] = 'Recipe not found or unauthorized access!'
      end
      redirect_to recipes_path
    end    
  
    private
  
    def recipe_params
        params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
    end

    def authorize_user
      recipe = Recipe.find(params[:id])
      unless current_user == recipe.user
        flash[:alert] = 'You are not authorized to perform this action.'
        redirect_to recipes_path
      end
    end
end
