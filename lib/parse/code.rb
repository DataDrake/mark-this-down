CODE = /```(\S*)\n([^`]*)```/
CODE_BLOCK = //
INLINE_CODE = /`([^`\n]+)`/

module MarkThisDown
  module Parse
    def code( wiki )
      wiki.gsub!(CODE , '<pre> <code class="\1">\2</code></pre>')
      wiki.gsub!(INLINE_CODE, '<code>\1</code>')
      wiki
    end
  end
end