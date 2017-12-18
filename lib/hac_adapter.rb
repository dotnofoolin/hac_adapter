require 'mechanize'
require 'terminal-table'
require 'hac_adapter/version'
require 'hac_adapter/exceptions'
require 'hac_adapter/setup'
require 'hac_adapter/login'
require 'hac_adapter/students'
require 'hac_adapter/grades'

module HacAdapter
  class << self
    def all_reports(params)
      data = []
      HacAdapter::Students.new(params).list_all.each do |student_id|
        data.push HacAdapter::Grades.new(params, student_id).scrape_for_data.results
      end

      data
    end

    def all_ascii_reports(params)
      data = []
      HacAdapter::Students.new(params).list_all.each do |student_id|
        data.push HacAdapter::Grades.new(params, student_id).scrape_for_data.ascii_report
      end

      data.join "\n\n"
    end
  end
end
