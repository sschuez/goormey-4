class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :user_recipes, :query_and_respond ]
  before_action :set_user, only: %i[ show user_recipes edit update destroy ]

  def show
    likes = @user.likes
    li_recipes = []
    likes.each do | like |
      li_recipes << like.recipe
    end
    li_recipes
    
    @liked_recipes = Recipe.where(id: li_recipes.map(&:id)).includes(:likes).order("likes.created_at desc")
    @user_recipes = @user.recipes.order(created_at: :desc)

    query_and_respond(@liked_recipes)
  end
  
  def user_recipes
    @user_recipes = @user.recipes
    query_and_respond(@user_recipes)
  end
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
  
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email)
  end
  
  # Query for both user_recipes and liked_recipes
  def query_and_respond(recipes)
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      recipes = recipes.where(sql_query, query: "%#{params[:query]}%")
    end
  
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "list", locals: { recipes: recipes }, formats: :html }
    end
  end
end
