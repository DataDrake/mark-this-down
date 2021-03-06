BOLD = /(?<=^|\s)([*_]{2})(.+?)\1(?=\s|$)/
ITALICS = /(?<=^|\s)([*_])(.+?)\1(?=\s|$)/
FORMAT_BOTH = /(?<=^|\s)([*_]{3})(.+?)\1(?=\s|$)/
STRIKETHROUGH = /(?<=|\s)([~]{2})(.+?)\1(?=\s|$)/

module MarkThisDown
  module Parse
    def formatting( wiki )
      wiki.gsub!(FORMAT_BOTH , '<b><i>\2</i></b>')
      wiki.gsub!(BOLD , '<b>\2</b>')
      wiki.gsub!(ITALICS , '<i>\2</i>')
      wiki.gsub!(STRIKETHROUGH , '<s>\2</s>')
      wiki
    end
  end
end