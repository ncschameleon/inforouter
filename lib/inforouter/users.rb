module Inforouter #:nodoc:
  class Users
    class << self
      # All users.
      #
      # @return [Hash]
      def all
        @users ||= begin
          response = Inforouter.client.request :get_all_users
          users = Inforouter::Responses::Users.parse response
          Hash[users.map { |user| [user.user_name, user] }]
        end
      end

      # Lookup a user by user name.
      #
      # @param user_name [String]
      #
      # @return [Inforouter::User]
      def [](user_name)
        all[user_name]
      end
    end
  end
end
