class Doctor < ApplicationRecord
    has_and_belongs_to_many :categories
    has_one :user, as: :profile, dependent: :destroy
    has_many :appointments
    has_many :patients, through: :appointments
end
