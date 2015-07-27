LIST = /((?:(?:  )*(?:\d\.|[*+-]) (?:.*)\n)+)/
LIST_ELEMENT = /(  )*(\d\.|[*+-]) (.*)/

BLOCKQUOTE = /((?:^[>][^\n>]+\n)+)/

UNORDERED = %w( - + *)
ORDERED = (1..9).to_a.map{|e| e.to_s}

module MarkThisDown
  module Parse
    def lists( wiki )
      wiki.gsub!(LIST) do | l |
        list = l.scan(LIST_ELEMENT)
        stack = []
        l = ''
        list.each do |e|
          ap e
          e[0] = '' if e[0].nil?
          if(e[0].length)/2 + 1 < (stack.length)
            top = stack.pop
            l = "#{l}</#{top}>"
          end
          if (e[0].length)/2 == stack.length
            if UNORDERED.include? e[1][0]
              stack.push('ul')
              l = "#{l}<ul>"
            elsif ORDERED.include? e[1][0]
              stack.push('ol')
              l = "#{l}<ol>"
            end
          end
          l = "#{l}<li>#{e[2]}</li>"
        end
        until stack.empty? do
          top = stack.pop
          l = "#{l}</#{top}>"
        end
        l
      end
      wiki.gsub!(BLOCKQUOTE) do | b |
        "<bq>#{b.gsub!('> ', '')}</bq>"
      end
      wiki
    end
  end
end