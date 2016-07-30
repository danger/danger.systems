# This file comes, verbatim aside from this notice
# from the CocoaPods Guides website.

module HTMLHelpers
  # Converts a markdown string to HTML.
  #
  # @param [String] input
  #
  # @return [String] HTML
  #
  def markdown_h(input)
    @markdown_instance ||= Redcarpet::Markdown.new(Class.new(Redcarpet::Render::HTML), $md_settings)
    # TODO: experimental
    @markdown_instance.render(capitalize_first_letter(input))
  end

  # Capitalizes the firs letter of a string.
  #
  # @return [String]
  #
  def capitalize_first_letter(input)
    (input.slice(0, 1).capitalize || '') + (input.slice(1..-1) || '')
  end

  # Highlights the given string with Pygments.
  #
  # @return [String]
  # @option [String] :language
  # @option [Fixnum] :line
  #         triggers line numbering.
  #
  def syntax_highlight(code, opts = {})
    HTMLHelpers.syntax_highlight(code, opts)
  end

  def self.syntax_highlight(code, opts = {})
    lexer = opts[:language] || 'ruby'
    py_options = { encoding: 'utf-8' }

    if line = opts[:line]
      py_options[:linenos] = 'inline'
      py_options[:linenostart] = line
    end

    Pygments.highlight(code, lexer: lexer, options: py_options)
  end
end
