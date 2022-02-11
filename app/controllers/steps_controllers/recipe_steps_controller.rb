module StepsControllers
  class RecipeStepsController < ApplicationController
    include Wicked::Wizard

    steps *Recipe.form_steps.keys

    def show
      @recipe = Recipe.wizard_not_completed_only.find(params[:recipe_id])
      authorize @recipe
      render_wizard
    end

    def update
      @recipe = Recipe.wizard_not_completed_only.find(params[:recipe_id])
      authorize @recipe
      # Use #assign_attributes since render_wizard runs a #save for us
      @recipe.assign_attributes recipe_params
      render_wizard @recipe
    end

    private

    # Only allow the params for specific attributes allowed in this step
    def recipe_params
      params.require(:recipe).permit(Recipe.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      @recipe.update! wizard_complete: true
      recipe_path(@recipe)
    end
  end
end