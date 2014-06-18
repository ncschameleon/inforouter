module Inforouter #:nodoc:
  class Users
    class << self
      # All users.
      def all
        @users ||= begin
          response = Inforouter.client.request :get_all_users
          users = Inforouter::Responses::GetAllUsers.parse response
          Hash[users.map { |user| [user.user_id, user] }]
        end
      end
    end
  end
end
