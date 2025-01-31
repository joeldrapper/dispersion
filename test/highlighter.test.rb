# frozen_string_literal: true

file = File.read("#{__dir__}/support/example.rb")

puts Dispersion.ansi file
