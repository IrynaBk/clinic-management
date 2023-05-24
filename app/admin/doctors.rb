ActiveAdmin.register Doctor do
  permit_params user_attributes: [:id, :first_name, :last_name, :phone, :email, :password, :password_confirmation], category_ids: []
  
  form do |f|
    f.inputs 'Doctor Details' do
      f.object.build_user if f.object.user.nil? # Build the user association if not already present
      f.fields_for :user do |user_fields|
        user_fields.input :first_name
        user_fields.input :last_name
        user_fields.input :phone
        user_fields.input :email
        user_fields.input :password
        user_fields.input :password_confirmation
      end
      f.input :categories, as: :select, collection: Category.all, multiple: true
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  controller do
    def create
      @doctor = Doctor.new()
      @doctor.category_ids = permitted_params[:doctor][:category_ids]
      @user = User.new(permitted_params[:doctor][:user_attributes]) # Build the associated user with the provided user params
      @user.profile = @doctor
      @doctor.user = @user
      if @doctor.save and @user.save
        redirect_to admin_doctor_path(@doctor), notice: 'Doctor created successfully.'
      else
        flash.now[:error] = @doctor.user.errors.full_messages.to_sentence
        render :new
      end
    end
  end
  # permit_params 
  #
  # or
  #
  # permit_params do
  #   permitted = []
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
