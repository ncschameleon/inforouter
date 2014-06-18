module Inforouter #:nodoc:
  class User < Record
    # User ID.
    attr_accessor :user_id
    # User domain.
    attr_accessor :domain
    # User username.
    attr_accessor :username
    # User first name.
    attr_accessor :first_name
    # User last name.
    attr_accessor :last_name
    # User email.
    attr_accessor :email
    # User enabled.
    attr_accessor :enabled

    def enabled?
      @enabled
    end
  end
end
