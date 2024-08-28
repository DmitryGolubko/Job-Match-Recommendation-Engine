# frozen_string_literal: true

require_relative 'base_model'

class JobSeeker < BaseModel
  attribute :id, Dry.Types::Coercible::Integer
  attribute :name, Dry.Types::String
  attribute :skills, Dry.Types::Array(Dry.Types::String)
end
