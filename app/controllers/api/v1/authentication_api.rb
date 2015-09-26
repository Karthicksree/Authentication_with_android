module API::V1
  class AuthenticationAPI < Base
  	namespace :user do

  		desc "User sign in"
      params do
        requires :email, type: String, desc: "Email ID"
        requires :password, type: String, desc: "Password"
      end

      post "signin" do
      	email = params[:email]
      	password = params[:password]

      	user = User.find_by(email: email.downcase)

      	if user.present? && password.present?
          Rails.logger.info "-------------#{params}"
	      	unless user.valid_password?(password)
	          {status: false, message: "Invalid Email or Password."}
	        else
	        	{status: true, message: "Signed in Successfully."}
	        end
	      else
          {status: false, message: "Invalid Email or Password."}
        end 
      end

      desc "User signup"
      params do
      	requires :user ,type: Hash do
	      	requires :name ,type: String
	      	requires :email, type: String
	      	requires :password, type: String
	      	requires :password_confirmation, type: String
	      end
      end

      post 'signup' do
        Rails.logger.info "-------------#{params}"
      	@user = User.create(name: params[:user][:name], email: params[:user][:email],
      	 password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      	if @user.save
        	{status: true, message: "You Have Register Successfully."}
      	else
      		{status: false, message: @user.erros}
      	end
      end

  	end
  end
end