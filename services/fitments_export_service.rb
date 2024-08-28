# frozen_string_literal: true

require_relative 'base_service'
require_relative '../models/job_seeker_fitment'

class FitmentsExportService < BaseService
  attribute :results_path, Dry.Types::String
  attribute :fitments, Dry.Types::Array(JobSeekerFitment)

  def process
    CSV.open(results_path, 'w', write_headers: true, headers: csv_header) do |writer|
      fitments.each do |fitment|
        writer << [
          fitment.job_seeker.id, fitment.job_seeker.name, fitment.job.id, fitment.job.title,
          fitment.matching_skills_count, format('%.1f', fitment.matching_skills_percent)
        ]
      end
    end
  end

  private

  def csv_header
    'jobseeker_id, jobseeker_name, job_id, job_title, matching_skill_count, matching_skill_percent'
  end
end
