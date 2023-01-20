class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :sucursal, optional:true
  validates :sucursal_id, absence: true, unless: :isStaff?
  validates :sucursal_id, absence: true, unless: :sucursal_id_exists?

  def admin?
    self.role == 'admin'
  end
  def staff?
    self.role == 'staff'
  end
  def client?
    self.role == 'client'
  end
  def isStaff?
    self.staff?
  end
  def sucursal_id_exists?
    !Sucursal.find_by_id(self.sucursal_id).nil?
  end



end
