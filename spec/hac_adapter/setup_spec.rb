require 'spec_helper'

describe 'HacAdapter::Setup' do
  let(:params) { auth_params }

  subject { HacAdapter::Setup.new(params) }

  describe '#new' do
    it 'returns object' do
      expect(subject).to be_a HacAdapter::Setup
    end

    it 'raises error if missing url' do
      params[:url] = nil
      expect { subject }.to raise_error(HacAdapter::UrlMissingError)
    end

    it 'raises error if missing school' do
      params[:school] = nil
      expect { subject }.to raise_error(HacAdapter::SchoolMissingError)
    end

    it 'raises error if missing username' do
      params[:username] = nil
      expect { subject }.to raise_error(HacAdapter::UsernameMissingError)
    end

    it 'raises error if missing password' do
      params[:password] = nil
      expect { subject }.to raise_error(HacAdapter::PasswordMissingError)
    end
  end
end