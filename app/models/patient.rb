class Patient < ApplicationRecord
    has_one :user, as: :profile, dependent: :destroy
    has_many :appointments
    has_many :doctors, through: :appointments
    accepts_nested_attributes_for :user

end
