class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.search(params[:query])
      .order(created_at: :desc)
      .page(params[:page])
      .without_count
      .per(14)

      skip_policy_scope
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new wizard_complete: false
    @recipe.ingredients.new
    @recipe.instructions.new
    @recipe.user = current_user
    authorize @recipe
    @recipe.save! validate: false
    redirect_to recipe_step_path(@recipe, Recipe.form_steps.keys.first)
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    authorize @recipe
    @recipe.user = current_user
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy
    redirect_to recipes_url, status: :see_other, notice: "Recipe was successfully deleted."
    # respond_to do |format|
    #   format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
      authorize @recipe
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:name, :description, :photo, :serves, ingredients_attributes: [:id, :description, :position, :_destroy], instructions_attributes: [:id, :description, :position, :_destroy])
    end
end
