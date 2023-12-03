# frozen_string_literal: true

require "erb"

module Dispersion
	module Formatters
		class HTML
			def initialize(code, annotations:)
				@code = code
				@annotations = annotations
			end

			def call
				lines = @code.lines
				current_symbol = nil
				buffer = +""

				lines.each_with_index do |line, line_number|
					cursor = 0

					@annotations[line_number].each do |(symbol, column)|
						buffer << ERB::Escape.html_escape(line[cursor...column])
						cursor = column

						# Always reset the current symbol
						if current_symbol
							buffer << "</span>"
							current_symbol = nil
						end

						unless symbol == :reset
							buffer << %(<span data-dispersion-symbol="#{symbol.name}">)
							current_symbol = symbol
						end

						# binding.irb
					end

					buffer << ERB::Escape.html_escape(line[cursor..])
				end

				if current_symbol
					buffer << "</span>"
					current_symbol = nil
				end

				buffer.gsub(/\t/, "  ")
			end
		end
	end
end
