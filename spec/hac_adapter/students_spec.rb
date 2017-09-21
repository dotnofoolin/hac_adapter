require 'spec_helper'

describe 'HacAdapter::Students' do
  let(:params) { auth_params }
  let(:student_id) { '373055' }
  let(:base_action) { HacAdapter::Students.new(params) }
  let(:action) { base_action }

  subject {
    VCR.use_cassette(cassette, record: :once) do
      action
    end
  }

  describe '#new' do
    let(:cassette) { 'get_login_page_and_submit' }

    it 'returns object' do
      expect(subject).to be_a HacAdapter::Students
    end

    it 'sets student_name' do
      expect(subject.student_name).to be_nil
    end

    it 'sets student_id' do
      expect(subject.student_id).to be_nil
    end
  end

  describe '#list_all' do
    let(:cassette) { 'get_students_list' }
    let(:action) { base_action.list_all }

    it 'returns array' do
      expect(subject).to be_a Array
    end

    it 'returns non nil values' do
      expect(subject.first).not_to be_nil
    end
  end

  describe '#select' do
    let(:cassette) { 'select_student' }
    let(:action) { base_action.select(student_id) }

    it 'returns object' do
      expect(subject).to be_a HacAdapter::Students
    end

    it 'contains mechanize response' do
      expect(subject.response).to be_a Mechanize::Page
    end

    it 'sets student_name attribute' do
      expect(subject.student_name).not_to be_nil
    end

    it 'sets student_id attribute' do
      expect(subject.student_id).not_to be_nil
    end
  end
end