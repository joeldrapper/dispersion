# frozen_string_literal: true

module Foo
	class Bar
		def initialize(bar, baz = 1, bing)
			bar + baz - bing
			@foo = bar
			bong = 1

			@a ||= 1
			@b &&= 2

			a ||= 1
			b &&= 2

			if a == 1 or b === 2 || d != 3 # inline comment
				binding.irb
			end
		end

		def foo(a, *b, c:, **d, &e)
			"Hello #{world}"
		end

		def bar = super

		def baz(*, **, &)
			if a
				"a"
			elsif b
				"b"
			else c
			  "d"
			end

			case foo
			when 1
				"1"
			else
				"2"
			end

			case bing
			in Array[Integer => a] | Array[Integer => b]
				"1 or 2"
			end
		end

		def qux(...)
			while a
				sleep 1
				next if a

				a ? b : c
			end

			until b
				sleep 1.5
			end

			(1..100).times do
				{
					[1 => 2]
				}
			end
		end
	end
end
