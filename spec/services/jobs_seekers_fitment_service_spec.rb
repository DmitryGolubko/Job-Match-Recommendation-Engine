# frozen_string_literal: true

require 'spec_helper'

require_relative '../../services/jobs_seekers_fitment_service'

describe JobSeekerFitmentService do
  subject(:service) { described_class.execute(job_seeker_file_path:, jobs:) }

  let(:job_seeker_file_path) { 'spec/fixtures/jobseekers.csv' }

  describe '.execute' do
    context 'when jobseekers are present' do
      let(:jobs) do
        [
          Job.new(id: 1, title: 'Sample Job', required_skills: %w[Ruby HTML/CSS TypeScript SQL]),
          Job.new(id: 2, title: 'Another Job', required_skills: %w[Ruby SQL])
        ]
      end

      it 'returns fitments sorted by the percentage of matching skills in descending order' do
        result = service.success
        expect(result.count).to eq 4

        expect(result[0].job_seeker.id).to eq 1
        expect(result[0].job.id).to eq 2
        expect(result[0].matching_skills_percent).to eq 100.0

        expect(result[1].job_seeker.id).to eq 1
        expect(result[1].job.id).to eq 1
        expect(result[1].matching_skills_percent).to eq 75.0

        expect(result[2].job_seeker.id).to eq 2
      end
    end

    context 'when jobseekers are not sorted by ID ascending' do
      let(:job_seeker_file_path) { 'spec/fixtures/jobseekers_desc.csv' }
      let(:jobs) do
        [Job.new(id: 1, title: 'Sample Job', required_skills: %w[Ruby HTML/CSS TypeScript SQL])]
      end

      it 'returns fitments sorted by jobseeker ID in ascending order' do
        result = service.success
        expect(result.count).to eq 2

        expect(result[0].job_seeker.id).to eq 1
        expect(result[1].job_seeker.id).to eq 2
      end
    end

    context 'when two jobs have same percentage of matching skills' do
      let(:jobs) do
        [
          Job.new(id: 1, title: 'Sample Job', required_skills: %w[Ruby SQL]),
          Job.new(id: 2, title: 'Another Job', required_skills: %w[Ruby SQL])
        ]
      end

      it 'returns fitments sorted by job ID in ascending order' do
        result = service.success
        expect(result.count).to eq 4

        expect(result[0].job_seeker.id).to eq 1
        expect(result[0].job.id).to eq 1
        expect(result[0].matching_skills_percent).to eq 100.0

        expect(result[1].job_seeker.id).to eq 1
        expect(result[1].job.id).to eq 2
        expect(result[1].matching_skills_percent).to eq 100.0
      end
    end
  end
end
