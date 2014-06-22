# The infoRouter Ruby Gem

[![Gem Version](http://img.shields.io/gem/v/inforouter.svg)][gem]
[![Build Status](http://img.shields.io/travis/ncssoftware/inforouter.svg)][travis]

[gem]: https://rubygems.org/gems/inforouter
[travis]: https://travis-ci.org/ncssoftware/inforouter

A Ruby interface to the infoRouter SOAP API

## Installation

Add this line to your application's Gemfile:

    gem 'inforouter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inforouter

## Usage

Configure your environment. For example, create an initializer in Rails in <tt>config/initializers/inforouter.rb</tt>.

    Inforouter.configure do |config|
      config.wsdl     = Rails.root.join('resources', 'inforouter.wsdl')
      config.host     = 'your_inforouter_host'
      config.username = 'your_inforouter_username'
      config.password = 'your_inforouter_password'
    end

## Using Inforouter

Creating an infoRouter folder using <tt>Inforouter::Folder</tt>.

    folder = Inforouter::Folder.new path: '/Path/To/Folder'
    folder.create unless folder.exists?
    folder.description = 'Some description'
    folder.update_properties

Make a SOAP request.

    message = {
      :path => '/Path/To/Document',
      'withPropertySets' => 1,
      'withSecurity' => 0,
      'withOwner' => 0,
      'withVersions' => 0
    }
    response = Inforouter.client.request :get_document, message

Return all infoRouter users.

    users = Inforouter::Users.all
    users.each { |user| puts "#{user.id}\t#{user.name}" }

Return the specified user.

	user = Inforouter::Users['JoeD']
	puts user.name # => 'Joe Dimaggio'

Set the access list of a folder in the specified path.

    folder = Inforouter::Folder.new path: '/Path/To/Folder'
    access_list.domain_members = Inforouter::AccessListDomainMembersItem.new(
      right: Inforouter::AccessList::ADD_AND_READ
    )
    access_list.user_groups << Inforouter::AccessListUserGroupItem.new(
      name: 'Authors',
      right: Inforouter::AccessList::ADD_AND_READ
    )
    access_list.user_groups << Inforouter::AccessListUserGroupItem.new(
      name: 'Developers',
      right: Inforouter::AccessList::CHANGE
    )
    access_list.user_groups << Inforouter::AccessListUserGroupItem.new(
      domain: 'ProjectX',
      name: 'Architect',
      right: Inforouter::AccessList::FULL_CONTROL
    )
    access_list.users << Inforouter::AccessListUserItem.new(
      domain: 'ProjectX',
      name: 'JoeD',
      right: Inforouter::AccessList::ADD_AND_READ
    )
    access_list.users << Inforouter::AccessListUserItem.new(
      domain: 'ProjectX',
      name: 'JaneC',
      right: Inforouter::AccessList::FULL_CONTROL
    )
    access_list.users << Inforouter::AccessListUserItem.new(
      name: 'SuzanP',
      right: Inforouter::AccessList::FULL_CONTROL
    )
    folder.access_list = access_list
    folder.update_access_list

The following right constants are defined in <tt>access_list.rb</tt>.

* <tt>NO_ACCESS</tt>
* <tt>LIST</tt>
* <tt>READ</tt>
* <tt>ADD</tt>
* <tt>ADD_AND_READ</tt>
* <tt>CHANGE</tt>
* <tt>FULL_CONTROL</tt>

Sets the rules of the specified folder. <tt>Inforouter::FolderRule</tt> rule items default to false and may be omitted.

    folder = Inforouter::Folder.new path: '/Path/To/Folder'
    rules = Inforouter::FolderRule.new(
              allowable_file_types: 'BMP,DOC,JPG,XLS',
              checkins: false,
              checkouts: false,
              document_deletes: false,
              folder_deletes: false,
              new_documents: false,
              new_folders: false,
              classified_documents: true
            )
    folder.rules = rules
    folder.update_rules

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2014 NCS Software.
See [LICENSE][] for further details.

[license]: LICENSE.md
