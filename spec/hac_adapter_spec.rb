require 'spec_helper'

describe 'HacAdapter' do
  let(:params) { auth_params }
  let(:base_action) { HacAdapter }
  let(:action) { base_action }

  subject {
    VCR.use_cassette(cassette, record: :once) do
      action
    end
  }

  describe '#VERSION' do
    it 'returns version' do
      expect(HacAdapter::VERSION).to_not be_nil
    end
  end

  describe '#all_reports' do
    let(:cassette) { 'get_all_students_reports' }
    let(:action) { base_action.all_reports(params) }

    it 'returns array' do
      expect(subject).to be_a Array
    end

    it 'returns data' do
      expect(subject).not_to be_empty
    end
  end

  describe '#all_ascii_reports' do
    let(:cassette) { 'get_all_students_reports' }
    let(:action) { base_action.all_ascii_reports(params) }

    it 'returns string' do
      expect(subject).to be_a String
    end

    it 'returns data' do
      expect(subject).not_to be_empty
    end
  end
end