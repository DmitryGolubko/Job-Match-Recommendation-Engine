# frozen_string_literal: true

require 'csv'
require 'pry'
require 'benchmark'

require_relative 'constants'

require_relative 'models/job_seeker_fitment'
require_relative 'models/job'
require_relative 'models/job_seeker'

require_relative 'services/fitments_export_service'
require_relative 'services/jobs_parse_service'
require_relative 'services/jobs_seekers_fitment_service'

class RecommendationEngine
  def execute
    JobsParseService.execute(file_path: JOBS_FILE_PATH).bind do |jobs|
      JobSeekerFitmentService.execute(job_seeker_file_path: JOB_SEEKERS_FILE_PATH, jobs:).bind do |fitments|
        FitmentsExportService.execute(results_path: RESULTS_PATH, fitments:)
      end
    end
  end
end

RecommendationEngine.new.execute
