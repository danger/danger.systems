# Require core library
require 'cgi'
require 'middleman-core'
require 'nokogiri'

# Our markdown parser gives us an id to each header but we also need an anchor in there for selection
# which means we have to do it all ourselves.

module Middleman
  class AddLinksToHeaders < Middleman::Extension
    def initialize(app, options_hash={}, &block)
      super
      app.after_render do |body, path, locs, template_class|

        # we get multiple render calls due to markdown / slim doing their thing
        #
        if (template_class.to_s.index 'Slim') != nil or (path.to_s.index 'templates') != nil

          doc = Nokogiri::HTML(body)
          nodes = doc.css('section article > h3[id], section article > h4[id]')

          if nodes.count > 0
            nodes.each do |header|
              next unless header.attributes['id']
              next if header.inner_html.include? 'header-link'

              id = header.attributes['id'].content.gsub(/[^a-zA-Z-]/, '')
              header.attributes['id'].value = id
              header.inner_html = "<a class='header-link' href='\##{id}'>#</a>" + header.inner_html
            end

            body = doc.to_s
          end
        end

        body
      end
    end
  end
end

::Middleman::Extensions.register(:add_links_to_headers) do
   Middleman::AddLinksToHeaders
end

