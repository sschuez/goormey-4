class User < ApplicationRecord
  # == Constants ============================================================
  
  # == Attributes ===========================================================
  
  # == Extensions ===========================================================
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  
  # == Relationships ========================================================
  has_many :recipes
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  
  include PgSearch::Model
  multisearchable against: [ :first_name, :last_name ]

  # == Validations ==========================================================
  # validates :username, uniqueness: true
  # validates :username, presence: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  after_create :send_welcome_email

  # == Class Methods ========================================================
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # == Instance Methods =====================================================

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

end
