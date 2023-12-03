# frozen_string_literal: true

file = File.read("#{__dir__}/support/example.rb")
puts
puts Dispersion::Highlighter.new(file).to_html
puts Dispersion::Highlighter.new(file).to_ansi
