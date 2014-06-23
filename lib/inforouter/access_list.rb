module Inforouter
  class AccessList < Record
    NO_ACCESS = 0
    LIST = 1
    READ = 2
    ADD = 3
    ADD_AND_READ = 4
    CHANGE = 5
    FULL_CONTROL = 6

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
    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.AccessList do
          xml.DomainMembers(domain_members.to_hash) if domain_members
          user_groups.each { |user_group| xml.UserGroup(user_group.to_hash) }
          users.each { |user| xml.User(user.to_hash) }
        end
      end
      builder.doc.root.to_xml
    end
  end
end
