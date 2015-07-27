## [ ]
LINK = /\[(.*)\]/

## [Audio:URN|label]
AUDIO_LINK = /\[Audio:\s*([^\|\]]+)\s*(?:\|\s*(.*))?\]/
## [Image:URN|label]
IMAGE_LINK = /\[Image:\s*([^\|\]]+)\s*(?:\|\s*(.*))?\]/
## [Video:URN|label]
VIDEO_LINK = /\[Video:\s*([^\|\]]+)\s*(?:\|\s*(.*))?\]/

## [Namespace:URN|Label]
INTERNAL_LINK1 = /\[([^\[\]:]*):\s*([^\|\]\[]+)\s*(?:\|\s*([^\]\[]*))?\]/
## [URN|Label]
INTERNAL_LINK2 = /\[([^:\|\]\[]+)\s*(?:\|\s*(.*))?\]/
## URN[|LABEL]
EXTERNAL_LINK = /^([^\|\[\]]+)(?:\|\s*(.+))?$/

module MarkThisDown
  module Parse
    def links( wiki )
      wiki.gsub!(LINK) do
        l = $1
        done = nil
        done = l.gsub!(AUDIO_LINK, "<audio controls><source src='#{$media}/\\1'></audio>" ) unless done
        done = l.gsub!(IMAGE_LINK, "<img src='#{$media}/\\1' alt='\\2'>" ) unless done
        done = l.gsub!(VIDEO_LINK, "<video controls><source src='#{$media}/\\1'></video>" ) unless done
        done = l.gsub!(INTERNAL_LINK1, "<a href='#{$base}/\\1/\\2'>\\3</a>" ) unless done
        done = l.gsub!(INTERNAL_LINK2, "<a href='\\1'>\\2</a>" ) unless done
        l.gsub!(EXTERNAL_LINK, "<a href='\\1'>\\2</a>" ) unless done
        l
      end
      wiki
    end
  end
end