TABLE = /((?:(?:\|[^|\n]*)*\|\n)+)/
TABLE_HEADER = /\A((?:\|[^|\n]*)*\|\n)(?:\| -+ )+\|\n/
TABLE_BODY = /(?:\| -+ )+\|\n((?:(?:\|[^|\n]*)*\|\n)*)/
TABLE_ROW = /((?:\|[^|\n]*)*\|\n)/
TABLE_CELL = /\| ([^|\n]+) /

module MarkThisDown
  module Parse
    def tables( wiki )
      wiki.gsub!(TABLE) do | t |
        table = '<table><thead>'
        header = t.match(TABLE_HEADER)
        header[1].scan(TABLE_ROW) do |r|
          ap r
          table = "#{table}<tr>"
          r[0].scan(TABLE_CELL) do |c|
            table = "#{table}<td>#{c[0]}</td>"
          end
          table = "#{table}</tr>"
        end
        table = "#{table}</thead><tbody>"
        body = t.match(TABLE_BODY)
        body[1].scan(TABLE_ROW) do |r|
          table = "#{table}<tr>"
          r[0].scan(TABLE_CELL) do |c|
            ap c
            table = "#{table}<td>#{c[0]}</td>"
          end
          table = "#{table}</tr>"
        end
        table = "#{table}</tbody></table>"
        table
      end
      wiki
    end
  end
end