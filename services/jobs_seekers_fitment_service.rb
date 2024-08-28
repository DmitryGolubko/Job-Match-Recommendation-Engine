# frozen_string_literal: true

require_relative 'base_service'
require_relative '../models/job'

class JobSeekerFitmentService < BaseService
  attribute :job_seeker_file_path, Dry.Types::String
  attribute :jobs, Dry.Types::Array(Job)

  def process
    all_fitments = []
    csv_content.sort_by { |row| row['id'].to_i }.each do |row|
      job_seeker_fitments = []

      job_seeker = JobSeeker.new(job_seeker_values(row))

      jobs.each do |job|
        job_seeker_fitments.push(JobSeekerFitment.new(job_seeker:, job:).fitment)
      end
      all_fitments.concat(job_seeker_fitments.sort_by { |fitment| [-fitment.matching_skills_percent, fitment.job.id] })
    end

    Success(all_fitments)
  end

  private

  def csv_content
    content = File.read(job_seeker_file_path)
    CSV.new(content, headers: true)
  end

  def job_seeker_values(row)
    id, name, raw_skills = row.values_at('id', 'name', 'skills')
    skills = raw_skills.split(', ')
    { id:, name:, skills: }
  end
end
