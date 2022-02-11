class Recipe < ApplicationRecord
	
	# == Constants ============================================================
	
	# == Attributes ===========================================================
	
	# == Extensions ===========================================================
	
	# == Relationships ========================================================
	has_many :ingredients, -> { order(position: :asc) }, dependent: :destroy, inverse_of: :recipe
	has_many :instructions, -> { order(position: :asc) }, dependent: :destroy, inverse_of: :recipe
	accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: :true
	accepts_nested_attributes_for :instructions, reject_if: :all_blank, allow_destroy: :true
	belongs_to :user
	has_one_attached :photo
	has_many :likes

	include PgSearch::Model
	multisearchable against: [ :name, :description ]

	# == Validations ==========================================================
	with_options if: -> { required_for_step?(:recipe) } do
		validates :name, presence: true, length: { minimum: 2, maximum: 100}
		validates :description, presence: true, length: { minimum: 2, maximum: 750}
		validates :serves, presence: true, numericality: { only_integer: true, in: 1..50 }
  end

  with_options if: -> { required_for_step?(:ingredients) } do
  end

	with_options if: -> { required_for_step?(:instructions) } do
	end

	# == Scopes ===============================================================
	default_scope { where wizard_complete: true }
	scope :wizard_not_completed_only, -> { unscope(where: :wizard_complete).where(wizard_complete: false) }

	# == Callbacks ============================================================
	
	# == Class Methods ========================================================
	enum form_steps: {
		recipe: [:name, :description, :serves, :photo],
		ingredients: [ingredients_attributes: [:id, :description, :_destroy]],
		instructions: [instructions_attributes: [:id, :description, :_destroy]]
	}
	attr_accessor :form_step

	def self.search(query)
		return all unless query.present?

		results = PgSearch.multisearch(query)

		recipes = []
		results.each do |result|
			if result.searchable_type == "Recipe"
				recipes << result.searchable
			elsif result.searchable_type == "User"
				result.searchable.recipes.each do | user_recipe |
					recipes << user_recipe
				end
			else
				recipes << Recipe.find(result.searchable.recipe_id)
			end
		end

		Recipe.where(id: recipes.map(&:id))
	end
	
	# == Instance Methods =====================================================
	def required_for_step?(step)
		# All fields are required if no form step is present
		return true if form_step.nil?
	
		# All fields from previous steps are required
		ordered_keys = self.class.form_steps.keys.map(&:to_sym)
		!!(ordered_keys.index(step) <= ordered_keys.index(form_step))
	end

end
