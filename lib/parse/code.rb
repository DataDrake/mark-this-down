CODE = /```(\S*)\n([^`]*)```/

module MarkThisDown
  module Parse
    def code( wiki )
      wiki.gsub!(CODE , '<pre code="\1">\2</pre>')
      wiki
    end
  end
end