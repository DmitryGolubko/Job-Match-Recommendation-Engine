# frozen_string_literal: true

require_relative 'base_model'
require_relative 'job_seeker'
require_relative 'job'

class JobSeekerFitment < BaseModel
  attribute :job_seeker, Dry.Types::Instance(::JobSeeker)
  attribute :job, Dry.Types::Instance(Job)

  attr_accessor :matching_skills_count, :matching_skills_percent

  def fitment
    @matching_skills_count = (job_seeker.skills & job.required_skills).length
    @matching_skills_percent = (@matching_skills_count.to_f / job.required_skills.length) * 100

    self
  end
end
