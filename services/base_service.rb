# frozen_string_literal: true

require 'dry/monads'
require 'dry-struct'

class BaseService < Dry::Struct
  include Dry::Monads[:result]
  include Dry.Types()

  def self.execute(**params)
    new(**params).execute
  end

  def execute
    process
  end

  def process(**_params)
    raise NotImplementedError
  end
end
