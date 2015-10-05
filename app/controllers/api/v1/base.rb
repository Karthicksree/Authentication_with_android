module API::V1
  class Base < API::ApplicationAPI

  	helpers do
			def warden
				env['warden']
			end

			def authenticated
				return true if warden.authenticated?
				Rails.logger.info"---------------------#{headers['Authorization']}"
				headers["Authorization"] && @user = User.find_by_authentication_token(headers["Authorization"])
			end

			def current_user
				warden.user || @user
			end
		end
    version "v1", :using => :path

    mount AuthenticationAPI
    mount PostAPI
    mount CommentAPI
   end
end