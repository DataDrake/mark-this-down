require 'awesome_print'
require_relative 'blocks'
require_relative 'code'
require_relative 'formatting'
require_relative 'headers'
require_relative 'links'
require_relative 'lists'
require_relative 'tables'

$base = '/edge'
$media = 'repos'

WIKI_OUTER = /(\A[^<]+|[^<>\n]+\z)/
WIKI_INNER = /<\/[^>]*>\n([^<]+)</
BREAK = /  $/

module MarkThisDown
  module Parse

    def parse2( wiki )
      wiki = blocks(wiki)
      ## Headers must occur before handling formatting because of HR conflict with Italics/Bold
      wiki = headers(wiki)
      wiki = formatting(wiki)
      ##wiki = links(wiki)
      wiki = tables(wiki)
      wiki = lists(wiki)
      ##wiki = code(wiki)
      wiki.gsub!(BREAK, '<br/>')
      ##wiki.delete!("\n")
      ##wiki.gsub!(/((?<=>|\A)[^<]+(?=<|\z))/, '<p>\1</p>')
      wiki
    end

    def parse( wiki )
      wiki.gsub!(WIKI_OUTER) do |w|
        parse2(w)
      end
      wiki.gsub!(WIKI_INNER) do |w|
        parse2(w)
      end
      CGI.unescapeHTML(wiki)
    end
  end
end