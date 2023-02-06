class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_many :appointments, dependent: :restrict_with_error
  has_many :appointments, foreign_key:"client_id", class_name:'Appointment', dependent: :restrict_with_error
  has_many :appointments_s, foreign_key:"staff_id", class_name:'Appointment', dependent: :restrict_with_error
  belongs_to :sucursal, optional:true

  validates :sucursal_id, absence: true, unless: :isStaff?
  validates :sucursal_id, absence: true, unless: :sucursal_id_exists?
  validates :sucursal_id, presence: true, if: :isStaff?


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
