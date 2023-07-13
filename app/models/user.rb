class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: self
  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :jogs
  def set_default_role
    self.role ||= :user
  end
end
