BOLD = /([*_]{2})(.+)\1/
ITALICS = /([*_])([^*_]+)\1/
STRIKETHROUGH = /~~([^~]+)~~/
BREAK = /^\n([*-_])\1{2,}/

module MarkThisDown
  module Parse
    def formatting( wiki )
      wiki.gsub!(BOLD , '<b>\2</b>')
      wiki.gsub!(ITALICS , '<i>\2</i>')
      wiki.gsub!(STRIKETHROUGH, '<s>\1</s>')
      wiki.gsub!(BREAK , '<hr/>')
      wiki
    end
  end
end