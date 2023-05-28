class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  has_one :recommendation, dependent: :destroy

  validates :verify_doctor, on: :create # verify if doctor's open appointments<= 10 
  
  enum status: { open: 0, closed: 1 }

  def verify_doctor
    open_appointments_count = doctor.appointments.where(status: 0).count
    if open_appointments_count >= 10
      errors.add("Doctor is not available.")
    end
  end
end



