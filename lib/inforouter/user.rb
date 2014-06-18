module Inforouter #:nodoc:
  class User < Record
    # User ID.
    attr_accessor :user_id
    # User domain.
    attr_accessor :domain
    # User username.
    attr_accessor :user_name
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

    def name
      [@first_name, @last_name].join(' ').strip
    end
  end
end
