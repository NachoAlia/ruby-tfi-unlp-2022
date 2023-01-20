class Sucursal < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  validates :nombre, presence:true, uniqueness:true
  validates :direccion, :telefono, presence: true
  validates :telefono, :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }
end
