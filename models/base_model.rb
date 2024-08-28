# frozen_string_literal: true

require 'dry/monads'
require 'dry-struct'

class BaseModel < Dry::Struct
  include Dry.Types()
end
