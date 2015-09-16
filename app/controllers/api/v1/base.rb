module API::V1
  class Base < API::ApplicationAPI
    version "v1", :using => :path

    mount AuthenticationAPI
   end
end