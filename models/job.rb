# frozen_string_literal: true

require_relative 'base_model'

class Job < BaseModel
  attribute :id, Dry.Types::Coercible::Integer
  attribute :title, Dry.Types::String
  attribute :required_skills, Dry.Types::Array(Dry.Types::String)
end
