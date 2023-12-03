# frozen_string_literal: true

require "prism"

module Dispersion
  class Annotator < Prism::Visitor
  	def self.call(code)
  		new(code).call
  	end

  	def initialize(code)
  		@code = code
  		@annotations = Array.new(code.count("\n")) { [] }
  	end

  	def call
  		parsed = Prism.parse(@code)
  		parsed.comments.each { |c| visit_comment(c) }
  		visit(parsed.value)

  		@annotations.map(&:sort!)
  	end

  	def highlight(type, loc)
  		return unless loc
  		return if loc.start_line == loc.end_line && loc.start_column == loc.end_column

  		@annotations[loc.start_line - 1] << Dispersion::Annotation.new(
  			type,
  			loc.start_character_column,
  		)

  		@annotations[loc.end_line - 1] << Dispersion::Annotation.new(
  			:reset,
  			loc.end_character_column,
  		)
  	end

  	def visit_comment(node)
  		highlight :comment, node.location
  	end

  	def visit_def_node(node)
  		highlight :keyword, node.def_keyword_loc
  		highlight :keyword, node.end_keyword_loc
  		highlight :call, node.name_loc
  		highlight :bracket, node.lparen_loc
  		highlight :bracket, node.rparen_loc
  		super
  	end

  	def visit_local_variable_write_node(node)
  		highlight :var, node.name_loc
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_local_variable_read_node(node)
  		highlight :var, node.location
  		super
  	end

  	def visit_instance_variable_write_node(node)
  		highlight :ivar, node.name_loc
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_instance_variable_and_write_node(node)
  		highlight :ivar, node.name_loc
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_instance_variable_or_write_node(node)
  		highlight :ivar, node.name_loc
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_instance_variable_read_node(node)
  		highlight :ivar, node.location
  		super
  	end

  	def visit_constant_read_node(node)
  		highlight :constant, node.location
  		super
  	end

  	def visit_class_node(node)
  		highlight :keyword, node.class_keyword_loc
  		highlight :keyword, node.end_keyword_loc
  		super
  	end

  	def visit_call_node(node)
  		highlight :call, node.message_loc
  		super
  	end

  	def visit_string_node(node)
  		highlight :string, node.location
  		super
  	end

  	def visit_interpolated_string_node(node)
  		highlight :string, node.opening_loc
  		highlight :string, node.closing_loc
  		super
  	end

  	def visit_symbol_node(node)
  		highlight :symbol, node.location
  		super
  	end

  	def visit_block_node(node)
  		if node.opening_loc.length == 1
  			highlight :bracket, node.opening_loc
  		else
  			highlight :keyword, node.opening_loc
  		end

  		if node.closing_loc.length == 1
  			highlight :bracket, node.closing_loc
  		else
  			highlight :keyword, node.closing_loc
  		end

  		super
  	end

  	def visit_case_node(node)
  		highlight :keyword, node.case_keyword_loc
  		highlight :keyword, node.end_keyword_loc
  		super
  	end

  	def visit_case_match_node(node)
  		highlight :keyword, node.case_keyword_loc
  		highlight :keyword, node.end_keyword_loc
  		super
  	end

  	def visit_module_node(node)
  		highlight :keyword, node.module_keyword_loc
  		highlight :keyword, node.end_keyword_loc
  		super
  	end

  	def visit_if_node(node)
  		highlight :keyword, node.if_keyword_loc
  		highlight :keyword, node.end_keyword_loc

  		if node.then_keyword&.length == 1
  			highlight :operator, node.then_keyword_loc
  		else
  			highlight :keyword, node.then_keyword_loc
  		end

  		super
  	end

  	def visit_when_node(node)
  		highlight :keyword, node.keyword_loc
  		super
  	end

  	def visit_else_node(node)
  		if node.else_keyword.length == 1
  			highlight :operator, node.else_keyword_loc
  		else
  			highlight :keyword, node.else_keyword_loc
  		end

  		highlight :keyword, node.end_keyword_loc

  		super
  	end

  	def visit_block_argument_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_and_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_or_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_local_variable_or_write_node(node)
  		highlight :var, node.name_loc
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_local_variable_and_write_node(node)
  		highlight :var, node.name_loc
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_rescue_node(node)
  		highlight :keyword, node.keyword_loc
  		highlight :keyword, node.operator_loc
  		super
  	end

  	def visit_rest_parameter_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_keyword_rest_parameter_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_block_parameter_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_while_node(node)
  		highlight :keyword, node.keyword_loc
  		highlight :keyword, node.closing_loc
  		super
  	end

  	def visit_until_node(node)
  		highlight :keyword, node.keyword_loc
  		highlight :keyword, node.closing_loc
  		super
  	end

  	def visit_next_node(node)
  		highlight :keyword, node.keyword_loc
  		super
  	end

  	def visit_integer_node(node)
  		highlight :numeric, node.location
  		super
  	end

  	def visit_float_node(node)
  		highlight :numeric, node.location
  		super
  	end

  	def visit_hash_node(node)
  		highlight :bracket, node.opening_loc
  		highlight :bracket, node.closing_loc
  		super
  	end

  	def visit_array_node(node)
  		highlight :bracket, node.opening_loc
  		highlight :bracket, node.closing_loc
  		super
  	end

  	def visit_assoc_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_forwarding_parameter_node(node)
  		highlight :operator, node.location
  		super
  	end

  	def visit_forwarding_super_node(node)
  		highlight :keyword, node.location
  	end

  	def visit_embedded_statements_node(node)
  		highlight :bracket, node.opening_loc
  		highlight :bracket, node.closing_loc
  		super
  	end

  	def visit_parentheses_node(node)
  		highlight :bracket, node.opening_loc
  		highlight :bracket, node.closing_loc
  		super
  	end

  	def visit_range_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_in_node(node)
  		highlight :keyword, node.in_loc
  		highlight :keyword, node.then_loc
  		super
  	end

  	def visit_array_pattern_node(node)
  		highlight :bracket, node.opening_loc
  		highlight :bracket, node.closing_loc
  		super
  	end

  	def visit_alternation_pattern_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_required_parameter_node(node)
  		highlight :var, node.location
  		super
  	end

  	def visit_optional_parameter_node(node)
  		highlight :var, node.name_loc
  		highlight :operator, node.operator_loc
  		super
  	end

  	def visit_capture_pattern_node(node)
  		highlight :operator, node.operator_loc
  		super
  	end
  end
end
