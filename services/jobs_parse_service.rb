# frozen_string_literal: true

require_relative 'base_service'

class JobsParseService < BaseService
  attribute :file_path, Dry.Types::Strict::String

  def process
    jobs = []
    content = File.read(file_path)
    csv = CSV.new(content, headers: true)

    csv.each do |line|
      id, title, raw_skills = line.values_at('id', 'title', 'required_skills')
      jobs.push(Job.new(id:, title:, required_skills: raw_skills.split(', ')))
    end

    Success(jobs)
  end
end
