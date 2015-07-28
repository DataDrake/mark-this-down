HEADER = /^([-#]{1,6}) ([^-#\n]+)[-#]*/
ALT_HEADER = /(^.+)\n([=\-])\2*/
HEADER_TYPE = {'=' => 1 , '-' => 2}
HORIZONTAL_BREAK = /^(([\-+*])\s?)\1+\2(?:[\t ])*$/

module MarkThisDown
  module Parse
    def headers( wiki )
      wiki.gsub!(HEADER) do
        "<h#{$1.length}>#{$2}</h#{$1.length}>"
      end
      wiki.gsub!(ALT_HEADER) do
        "<h#{HEADER_TYPE[$2]}>#{$1}</h#{HEADER_TYPE[$2]}>"
      end
      wiki.gsub!(HORIZONTAL_BREAK , '<hr/>')
      wiki
    end
  end
end