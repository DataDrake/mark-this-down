BLOCK_QUOTE = /((?:> .*\n)+)/
QUOTE = /> (.*\n)/
PARAGRAPH = Regexp.new /((?<=>|\A)[^<]+(?=<|\z))/

module MarkThisDown
  module Parse
    def blocks( wiki )
      while wiki.match(BLOCK_QUOTE)
        wiki.gsub!(BLOCK_QUOTE) do |b|
          b.gsub!(QUOTE, '\1')
          "<bq>#{b}</bq>"
        end
      end
      wiki
    end
  end
end