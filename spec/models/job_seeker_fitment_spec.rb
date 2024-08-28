# frozen_string_literal: true

require 'spec_helper'

require_relative '../../models/job_seeker_fitment'

describe JobSeekerFitment do
  describe '.fitment' do
    context 'when provided data are correct' do
      let(:job_seeker) { JobSeeker.new(id: '1', name: 'John Snow', skills: %w[Ruby Rails Javascript TypeScript]) }
      let(:job) { Job.new(id: '1', title: 'Full-Stack Developer', required_skills: %w[Ruby Rails Javascript HTML]) }

      it 'returns correct matching skills count and percentage' do
        fitment = JobSeekerFitment.new(job_seeker:, job:).fitment
        expect(fitment.matching_skills_count).to eq(3)
        expect(fitment.matching_skills_percent).to eq(75.0)
      end
    end
  end
end
