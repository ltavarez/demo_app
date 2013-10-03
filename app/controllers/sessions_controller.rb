class SessionsController < ApplicationController
  def new
  end
  
  def create
      email = Usuario.find_by(email: params[:session][:email].downcase)
      pass = Usuario.find_by(password: params[:session][:password])
      if email.nil? || pass.nil?
          flash.now[:error] = 'Invalid email/password combination'
           render 'new'
        # Create an error message and re-render the signin form.        
      else
        sign_in email
        redirect_to email
      end
   end

   def destroy
    sign_out
    redirect_to root_path
  end
end
