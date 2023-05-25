class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  has_one :recommendation, dependent: :destroy

  validate :verify_doctor, on: :create # verify if doctor's open appointments<= 10 


  def verify_doctor
    open_appointments_count = doctor.appointments.where(status: 0).count
    if open_appointments_count > 10
      errors.add(:doctor_id, "is not available. Maximum open appointments limit reached.")
    end
  end
end



