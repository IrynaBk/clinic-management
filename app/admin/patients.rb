ActiveAdmin.register Patient do

  permit_params user_attributes: [:first_name, :last_name, :phone, :email]

  filter :user_first_name, as: :string, label: 'First name'
  filter :user_last_name, as: :string, label: 'Last name'
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :first_name do |patient|
      patient.user.first_name
    end
    column :last_name do |patient|
      patient.user.last_name
    end
    column :email do |patient|
      patient.user.email
    end
    column :phone do |patient|
      patient.user.phone
    end    
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name do |patient|
        patient.user.first_name
      end
      row :last_name do |patient|
        patient.user.last_name
      end
      row :phone do |patient|
        patient.user.phone
      end
      # row :email do |patient|
      #   patient.user.email
      # end
      row :created_at
      row :updated_at
      # Add more rows as needed
    end
  end

  form do |f|
    f.inputs 'User Details', for: [:user, f.object.user] do |u|
      u.input :first_name, as: :string, input_html: { value: u.object.first_name }
      u.input :last_name, as: :string, input_html: { value: u.object.last_name }
      u.input :phone, as: :string, input_html: { value: u.object.phone }
      u.input :email, as: :string, input_html: { value: u.object.email }

    end
    f.actions
  end

  controller do
    def update
      @patient = Patient.find(params[:id])
      if @patient.user.update(permitted_params[:patient][:user_attributes]) # UPDATED AT AND CREATED AT NOT WORKING
        redirect_to admin_patient_path(@patient), notice: 'Patient updated successfully.'
      else
        flash.now.error = @patient.user.errors.full_messages.to_sentence
        render :edit
      end
    end

  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
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
