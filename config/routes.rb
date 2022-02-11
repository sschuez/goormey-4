Rails.application.routes.draw do

    # RECIPES
  resources :recipes do
    # NESTED SORTABLE INSTRUCTIONS
    resources :instructions do
      resource :instruction_position, only: :update
    end
      
    # NESTED SORTABLE INGREDIENTS
    resources :ingredients do  
      resource :ingredient_position, only: :update
    end

    # FORM WIZARD
    resources :steps, only: [:show, :update], controller: 'steps_controllers/recipe_steps'

    # LIKEABLE
    post 'likes', to: "likes#create"
    delete 'likes', to: "likes#destroy"
  end
    

  # USERS
  devise_for :users
  resources :users, only: [:index, :show] do
    member do
      get 'user_recipes'
    end
  end
    
  # CONTACTS
  resources :contacts, only: [:new, :create]

  # LAYOUTS
  root to: 'recipes#index'

end
