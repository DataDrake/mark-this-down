HEADER = /^([#]+)\s*([\w\s]*)\s*\n/
ALT_HEADER = /(?:\A|\n)([^\n]+)\n([-=])\2{2,}/
HEADER_TYPE = {'=' => 1 , '-' => 2}

module MarkThisDown
  module Parse
    def headers( wiki )
      wiki.gsub!(HEADER) do
        "<h#{$1.length}>#{$2}</h#{$1.length}>"
      end
      wiki.gsub!(ALT_HEADER) do
        "<h#{HEADER_TYPE[$2]}>#{$1}</h#{HEADER_TYPE[$2]}>"
      end
      wiki
    end
  end
end