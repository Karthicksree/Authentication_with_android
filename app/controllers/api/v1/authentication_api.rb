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
            user.ensure_authentication_token
            user.save
            {status: true, message: 'Signed in Successfully', token: user.authentication_token, current_user: current_user}
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
          requires :mobile_number, type: Integer
          requires :gender, type: String
          requires :photo, :type => Rack::Multipart::UploadedFile
	      end
      end

      post 'signup' do
        Rails.logger.info "-------------#{params}"
        params[:user][:photo] = ActionDispatch::Http::UploadedFile.new(params[:user][:photo])
      	@user = User.create(name: params[:user][:name], email: params[:user][:email],
      	 password: params[:user][:password], password_confirmation: params[:user][:password_confirmation],
         mobile_number: params[:user][:mobile_number],gender: params[:user][:gender], photo: params[:user][:photo])
      	if @user.save
        	{status: true, message: "You Have Register Successfully."}
      	else
      		{status: false, message: @user.erros}
      	end
      end

      desc "signout a user"

      params do
        requires :token
      end

      delete '/signout' do
        user = User.find_by(authentication_token: params[:token])
        user.update(authentication_token: nil)
        {status: true, message: 'Signed out Successfully'}
      end

  	end
  end
end