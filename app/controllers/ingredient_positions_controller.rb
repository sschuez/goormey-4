class IngredientPositionsController < ApplicationController
  def update
    @ingredient = Ingredient.find(params[:ingredient_id])
    authorize @ingredient.recipe

    @ingredient.insert_at(params[:position].to_i)
    head :ok
  end
end