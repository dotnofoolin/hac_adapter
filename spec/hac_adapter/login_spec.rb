require 'spec_helper'

describe 'HacAdapter::Login' do
  let(:params) { auth_params }
  let(:base_action) { HacAdapter::Login.new(params) }
  let(:action) { base_action }

  subject {
    VCR.use_cassette(cassette, record: :once) do
      action
    end
  }

  describe '#new' do
    let(:cassette) { 'get_login_page_and_submit' }

    it 'returns object' do
      expect(subject).to be_a HacAdapter::Login
    end
  end

  describe '#login' do
    let(:cassette) { 'get_login_page_and_submit' }
    let(:action) { base_action.login }

    describe 'when school is good' do
      it 'returns object' do
        expect(subject).to be_a HacAdapter::Login
      end

      it 'sets response properly' do
        expect(subject.response).to be_a Mechanize::Page
      end
    end

    describe 'when school is bad' do
      it 'raises error' do
        params[:school] = 'Some Random School'
        expect { subject }.to raise_error(HacAdapter::SchoolNotFoundError)
      end
    end

    describe 'when username or password is bad' do
      let(:cassette) { 'bad_login_attempt' }

      it 'raises error' do
        params[:username] = 'Test.User'
        params[:password] = 'testpassword'
        expect { subject }.to raise_error(HacAdapter::NotLoggedInError)
      end
    end
  end
end
