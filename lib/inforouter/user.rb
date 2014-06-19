module Inforouter #:nodoc:
  # A <tt>User</tt> defines an infoRouter user.
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
    # User last login date
    attr_accessor :last_logon
    # User last password change
    attr_accessor :last_password_change
    # User authentication authority.
    attr_accessor :authentication_authority
    # User read only.
    attr_accessor :read_only
    # User enabled.
    attr_accessor :enabled

    def read_only?
      @read_only
    end

    def enabled?
      @enabled
    end

    def name
      [@first_name, @last_name].join(' ').strip
    end
  end
end
