module Inforouter
  class AccessList
    # The AccessList XML fragment should be structures as
    #
    # <AccessList>
    #   <DomainMembers Right="2"/>
    #   <UserGroup Domain="" GroupName="Authors" Right="4"/>
    #   <UserGroup Domain="" GroupName="Developers" Right="5"/>
    #   <UserGroup Domain="ProjectX" GroupName="Architect" Right="6"/>
    #   <User Domain="ProjectX" UserName="JoeD" Right="4"/>
    #   <User Domain="ProjectX" UserName="JaneC" Right="6"/>
    #   <User Domain="" UserName="SuzanP" Right="6"/>
    # </AccessList>
    #
    # The Right Value can be
    #
    # 0 (No Access)
    # 1 (List)
    # 2 (Read)
    # 3 (Add)
    # 4 (Add & Read)
    # 5 (Change)
    # 6 (Full Control)
    NO_ACCESS = 0
    LIST = 1
    READ = 2
    ADD = 3
    ADD_AND_READ = 4
    CHANGE = 5
    FULL_CONTROL = 6

    def self.domain_members_item(xml, right)
      xml.DomainMembers(:Right => right)
    end

    def self.user_group_item(xml, options = {})
      xml.UserGroup(
        :Domain    => options[:domain],
        :GroupName => options[:group_name],
        :Right     => options[:right]
      )
    end

    def self.user_item(xml, options = {})
      xml.User(
        :Domain   => options[:domain],
        :UserName => options[:user_name],
        :Right    => options[:right]
      )
    end
  end
end
