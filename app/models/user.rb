class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :secure_validatable, :timeoutable,
         :password_expirable, :password_archivable, :confirmable, :lockable, :expirable, :session_limitable

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:new_user) if self.roles.blank?
  end

  has_many :upload_files
  has_one :employer
end
