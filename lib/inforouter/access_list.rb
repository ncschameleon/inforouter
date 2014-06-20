module Inforouter
  class AccessList
    NO_ACCESS = 0
    LIST = 1
    READ = 2
    ADD = 3
    ADD_AND_READ = 4
    CHANGE = 5
    FULL_CONTROL = 6

    def initialize
      @domain_members = []
      @user_groups = []
      @users = []
    end

    def add_domain_member(options = {})
      options = { right: NO_ACCESS }.merge(options)
      @domain_members << { right: options[:right] }
    end

    def add_user_group(options = {})
      options = {
        domain: nil,
        name: nil,
        right: NO_ACCESS
      }.merge(options)
      @user_groups << {
        domain: options[:domain],
        name: options[:name],
        right: options[:right]
      }
    end

    def add_user(options = {})
      options = {
        domain: nil,
        name: nil,
        right: NO_ACCESS
      }.merge(options)
      @users << {
        domain: options[:domain],
        name: options[:name],
        right: options[:right]
      }
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
          @domain_members.each do |domain_member|
            xml.DomainMember(:Right => domain_member[:right])
          end
          @user_groups.each do |user_group|
            xml.UserGroup(
              :Domain => user_group[:domain],
              :GroupName => user_group[:name],
              :Right => user_group[:right]
            )
          end
          @users.each do |user|
            xml.User(
              :Domain => user[:domain],
              :UserName => user[:name],
              :Right => user[:right]
            )
          end
        end
      end
      builder.doc.root.to_xml
    end
  end
end
