class AppointmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_appointment, only: [:show, :edit, :destroy]

    def create
        @appointment = Appointment.new(appointment_params)
    
        if @appointment.save
          redirect_to @appointment, notice: 'Appointment was successfully created.'
        else
          render :new
        end
    end

    def new
        @appointment = Appointment.new
    end

    def destroy
        @appointment.destroy
        redirect_to appointments_path, notice: 'Appointment was successfully destroyed.'
    end

    def index
        @appointments = current_user.profile.appointments
    end


    private

    def appointment_params
        params.require(:appointment).permit(:doctor_id, :patient_id)
    end

    def set_appointment
        @appointment = Appointment.find(params[:id])
    end
end
