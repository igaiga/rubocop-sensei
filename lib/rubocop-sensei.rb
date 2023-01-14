# frozen_string_literal: true

require 'rubocop'
require 'typeprof'

require_relative 'rubocop/sensei'
require_relative 'rubocop/sensei/version'
require_relative 'rubocop/sensei/inject'

RuboCop::Sensei::Inject.defaults!

require_relative 'rubocop/cop/sensei_cops'
