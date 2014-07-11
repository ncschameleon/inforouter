module Inforouter
  class AccessList < Record
    # The <tt>Inforouter::AccessListDomainMembersItem</tt>.
    attr_accessor :domain_members
    # Array of <tt>Inforouter::AccessListUserGroupItem</tt>s.
    attr_accessor :user_groups
    # Array of <tt>Inforouter::AccessListUserItem</tt>s.
    attr_accessor :users

    def initialize(params = {})
      params = {
        :user_groups => [],
        :users => []
      }.merge(params)
      super params
    end

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
    #
    # Example
    #
    # {
    #   :access_list => {
    #     :domain_members => { :@Right => 2 },
    #     :user_group => [
    #       { :@Domain => nil, :@UserGroupName => "Authors", :@Right => 4 },
    #       { :@Domain => nil, :@UserGroupName => "Developers", :@Right => 5 },
    #       { :@Domain => nil, :@UserGroupName => "JoeD", :@Right => 6 }
    #     ],
    #     :user => [
    #       { :@Domain => "ProjectX", :@UserName => "JoeD", :@Right => 4},
    #       { :@Domain => "ProjectX", :@UserName => "JaneC", :@Right => 6},
    #       { :@Domain => nil, :@UserName => "SuzanP", :@Right => 6}
    #     ]
    #   }
    # }
    #
    # @return [Hash]
    def to_hash
      access_list_hash = {
        :domain_members => nil,
        :user_group => [],
        :user => []
      }
      access_list_hash[:domain_members] = domain_members.to_hash if domain_members
      user_groups.each { |user_group| access_list_hash[:user_group] << user_group.to_hash }
      users.each { |user| access_list_hash[:user] << user.to_hash }
      { :access_list => access_list_hash }
    end
  end
end
