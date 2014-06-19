module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Get All Users API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=GetAllUsers
    class Users < Base
      response_success 'get_all_users_response/get_all_users_result/response/@success'
      error_message 'get_all_users_response/get_all_users_result/response/@error'

      class << self
        # Parse an infoRouter response.
        #
        # @param savon_response [Savon::Response] SOAP response.
        #
        # @return [Array]
        def parse(savon_response)
          response = new(savon_response)
          users = response.match('get_all_users_response/get_all_users_result/response/users/user')
          users.map do |user|
            Inforouter::User.new(
              :user_id => user[:@user_id].to_i,
              :domain => user[:@domain].strip,
              :user_name => user[:@user_name].strip,
              :first_name => user[:@first_name].strip,
              :last_name => user[:@last_name].strip,
              :last_login => DateTime.strptime(folder[:@last_login_date], '%Y-%m-%d %H:%M:%S'),
              :last_password_change => DateTime.strptime(folder[:@last_password_change_date], '%Y-%m-%d %H:%M:%S'),
              :authentication_authority => user[:@authentication_authority].strip,
              :read_only => user[:@read_only_user] == 'TRUE'
              :email => user[:@email].strip,
              :enabled => user[:@enabled] == 'TRUE'
            )
          end
        end
      end
    end
  end
end
