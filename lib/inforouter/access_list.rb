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
    # @return [String]
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.AccessList do
          xml.DomainMembers(:Right => domain_members.right) if domain_members
          user_groups.each do |user_group|
            xml.UserGroup(
              :Domain    => user_group.domain,
              :GroupName => user_group.name,
              :Right     => user_group.right
            )
          end
          users.each do |user|
            xml.User(
              :Domain   => user.domain,
              :UserName => user.name,
              :Right    => user.right
            )
          end
        end
      end
      builder.doc.root.to_s
    end
  end
end
