#app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  def new
    if user_signed_in?
      redirect_to root_path
    else
      self.resource = resource_class.new(sign_in_params)

      # Chúng ta sẽ gọi LoginValidator ở đây
      resource.validates_with(UserValidate) unless sign_in_params.empty?

      clean_up_passwords(resource)
      yield resource if block_given?
      respond_with(resource, serialize_options(resource))
    end
  end
end
