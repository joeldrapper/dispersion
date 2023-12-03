# frozen_string_literal: true

module Dispersion
	module Formatters
		class ANSI
      Regular = "\e[22m"
     	Bold = "\e[1m"
     	Faint = "\e[2m"
     	Reset = "\e[0m"
     	Italic = "\e[3m"
     	Underline = "\e[4m"

     	# Basic Colors
     	Black = "\e[30m"
     	Red = "\e[31m"
     	Green = "\e[32m"
     	Yellow = "\e[33m"
     	Blue = "\e[34m"
     	Magenta = "\e[35m"
     	Cyan = "\e[36m"
     	White = "\e[37m"

     	# Bright Colors
     	BrightBlack = "\e[90m"
     	BrightRed = "\e[91m"
     	BrightGreen = "\e[92m"
     	BrightYellow = "\e[93m"
     	BrightBlue = "\e[94m"
     	BrightMagenta = "\e[95m"
     	BrightCyan = "\e[96m"
     	BrightWhite = "\e[97m"

			DEFAULT_ANSI = {
				call: Red,
				string: Yellow,
				keyword: Cyan,
				comment: Italic + Magenta,
				var: "",
				constant: Blue,
				ivar: Blue,
				symbol: Green,
				numeric: Green,
				bracket: "",
				operator: "\e[36m",
			}

			def initialize(code, annotations:, theme:)
				@code = code
				@annotations = annotations
				@marks = DEFAULT_ANSI
			end

			def call
				lines = @code.lines
				current_symbol = nil
				buffer = +""

				lines.each_with_index do |line, line_number|
					cursor = 0

					@annotations[line_number].each do |(symbol, column)|
						buffer << line[cursor...column]
						cursor = column

						# Always reset the current symbol
						if current_symbol
							buffer << Reset
							current_symbol = nil
						end

						unless symbol == :reset
							buffer << @marks.fetch(symbol)
							current_symbol = symbol
						end
					end

					buffer << line[cursor..]
				end

				if current_symbol
					buffer << Reset
					current_symbol = nil
				end

				buffer.gsub(/\t/, "  ")
			end
		end
	end
end
