class LikesController < ApplicationController
  
  def create
    like = Like.new
    recipe = Recipe.find(params[:recipe_id])
    user = current_user
    like.recipe = recipe
    like.user = user
    authorize like
    like.save!
    head :ok
  end
  
  def destroy
    recipe = Recipe.find(params[:recipe_id])
    user = current_user
    # like = user.likes.where(recipe_id: recipe.id)
    like = Like.where(recipe_id: recipe.id, user_id: user.id)
    authorize like
    like.destroy_all
    head :ok
  end
end