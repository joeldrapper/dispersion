# frozen_string_literal: true

module Dispersion
  class Highlighter
  	def initialize(code)
  		@code = code
  		@annotations = Dispersion::Annotator.call(code)
  		freeze
  	end

  	def to_ansi(theme: nil)
  		Dispersion::Formatters::ANSI.new(@code, annotations: @annotations, theme:).call
  	end

  	def to_html
  		Dispersion::Formatters::HTML.new(@code, annotations: @annotations).call
  	end
  end
end
