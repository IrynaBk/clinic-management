class DoctorsController < ApplicationController
  def index
    @categories = Category.all
    @doctors = if params[:category_ids]
                  Doctor.joins(:categories).where('categories.id IN (?)', params[:category_ids])
                else
                    Doctor.all
                end
  end

  def show
    @doctor = Doctor.find(params[:id])
  end
end
