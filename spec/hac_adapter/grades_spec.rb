require 'spec_helper'

describe 'HacAdapter::Grades' do
  let(:params) { auth_params }
  let(:student_id) { '373055' }
  let(:base_action) { HacAdapter::Grades.new(params, student_id) }
  let(:action) { base_action }

  subject {
    VCR.use_cassette(cassette, record: :once) do
      action
    end
  }

  describe '#new' do
    let(:cassette) { 'select_student' }

    it 'returns object' do
      expect(subject).to be_a HacAdapter::Grades
    end

    it 'sets student_id' do
      expect(subject.student_id).to eq student_id
    end

    it 'sets results' do
      expect(subject.results).to be_nil
    end
  end

  describe '#scrape_for_data' do
    let(:cassette) { 'get_assignments' }
    let(:action) { base_action.scrape_for_data }

    it 'returns object' do
      expect(subject).to be_a HacAdapter::Grades
    end

    describe 'when accessing results' do
      it 'returns hash' do
        expect(subject.results).to be_a Hash
      end

      it { expect(subject.results).to have_key(:student_name) }
      it { expect(subject.results).to have_key(:student_id) }
      it { expect(subject.results).to have_key(:classes) }

      it { expect(subject.results[:classes].first).to have_key(:class_name) }
      it { expect(subject.results[:classes].first).to have_key(:last_update) }
      it { expect(subject.results[:classes].first).to have_key(:average) }
      it { expect(subject.results[:classes].first).to have_key(:assignments) }

      it { expect(subject.results[:classes].first[:assignments].first).to have_key(:due_date) }
      it { expect(subject.results[:classes].first[:assignments].first).to have_key(:date_assigned) }
      it { expect(subject.results[:classes].first[:assignments].first).to have_key(:assignment_name) }
      it { expect(subject.results[:classes].first[:assignments].first).to have_key(:category) }
      it { expect(subject.results[:classes].first[:assignments].first).to have_key(:score) }
      it { expect(subject.results[:classes].first[:assignments].first).to have_key(:total_points) }
    end
  end

  describe '#ascii_report' do
    let(:cassette) { 'get_assignments' }
    let(:action) { base_action.scrape_for_data.ascii_report }

    it 'returns string' do
      expect(subject).to be_a String
    end

    describe 'when results are nil' do
      let(:action) { base_action.ascii_report }

      it 'raises error' do
        expect { subject }.to raise_error(HacAdapter::NilResultsError)
      end
    end
  end
end