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

# def print_memory_usage
#   memory_command = "ps -o rss= -p #{Process.pid}"
#   memory_before = %x(#{memory_command}).to_i
#   yield
#   memory_after = %x(#{memory_command}).to_i
#   puts "Memory: #{((memory_after - memory_before) / 1024.0).round(2)} MB"
# end

# def print_time_spent(&block)
#   time = Benchmark.realtime(&block)
#   puts "Time: #{time.round(2)}"
# end

class RecommendationEngine
  def execute
    # print_memory_usage do
      # print_time_spent do
        JobsParseService.execute(file_path: JOBS_FILE_PATH).bind do |jobs|
          JobSeekerFitmentService.execute(job_seeker_file_path: JOB_SEEKERS_FILE_PATH, jobs:).bind do |fitments|
            FitmentsExportService.execute(results_path: RESULTS_PATH, fitments:)
          end
        end
      # end
    # end
  end
end

RecommendationEngine.new.execute
