module Inforouter #:nodoc:
  module Responses #:nodoc:
    # Response to an infoRouter Set Folder Rules API call.
    #
    # See http://www.inforouter.com/web-services-80/default.aspx?op=SetFolderRules
    class SetFolderRules < Generic
      response_key :set_folder_rules
    end
  end
end
