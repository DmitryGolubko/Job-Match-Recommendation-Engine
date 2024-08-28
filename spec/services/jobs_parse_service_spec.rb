# frozen_string_literal: true

require 'spec_helper'

require_relative '../../services/jobs_parse_service'

describe JobsParseService do
  subject(:service) { described_class.execute(file_path:) }

  let(:file_path) { 'spec/fixtures/jobs.csv' }

  describe '.execute' do
    context 'when csv file exists and correct' do
      let(:expected_parsed_job) do
        Job.new(id: '1', title: 'Ruby Developer', required_skills: ['Ruby', 'SQL', 'Problem Solving'])
      end

      it 'parses and returns array of jobs' do
        result = service.success
        expect(result.count).to eq(1)
        expect(result.first.attributes).to eq(expected_parsed_job.attributes)
      end
    end
  end
end
