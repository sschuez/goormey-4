class Ingredient < ApplicationRecord

  #Organisation Model (Shortcut: mstr)
  # == Constants ============================================================
 
  # == Attributes ===========================================================
  
  # == Extensions ===========================================================
  acts_as_list scope: :recipe

  
  # == Relationships ========================================================
  belongs_to :recipe
  
  include PgSearch::Model
  multisearchable against: :description

  # == Validations ==========================================================

  # == Scopes ===============================================================
  
  # == Callbacks ============================================================
  
  # == Class Methods ========================================================
  
  # == Instance Methods =====================================================
  
end
