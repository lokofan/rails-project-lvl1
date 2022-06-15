# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/form'
require_relative 'hexlet_code/form_builder'

module HexletCode
  class Error < StandardError; end

  extend HexletCode::Form
end
