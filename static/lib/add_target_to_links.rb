# Require core library
require 'cgi'
require 'middleman-core'
require 'nokogiri'

# we want each link linking to an external page open in a new window by setting
# the target

module Middleman
  class AddTargetToLinks < Middleman::Extension
    def initialize(app, options_hash = {}, &block)
      super
      app.after_render do |body, path, _locs, template_class|
        # we get multiple render calls due to markdown / slim doing their thing
        #
        if (template_class.to_s.index 'Slim') != nil || (path.to_s.index 'templates') != nil
          doc = Nokogiri::HTML(body)
          nodes = doc.css('a')

          if nodes.count > 0
            nodes.each do |link|
              link['target'] = '_blank' if !has_target(link) && is_external(link)
            end

            body = doc.to_s
          end
        end

        body
      end
    end

    private

    def has_target(link)
      link['target'].present?
    end

    def is_external(link)
      link['href'].to_s.include?('http')
    end
  end
end

::Middleman::Extensions.register(:add_target_to_links) do
  Middleman::AddTargetToLinks
end
