module HacAdapter
  class Grades < Students
    attr_reader :student, :results

    def initialize(params, student_id)
      super(params)
      @student = select(student_id)
      @results = nil
    end

    def scrape_for_data
      # TODO: break this method up into smaller, more testable methods.

      @response = agent.get("#{@url}/Content/Student/Assignments.aspx") # This is the content of the iframe typically displayed on the Classwork page.

      classes = []
      @response.search('div.AssignmentClass').each do |class_div|
        class_name = clean_text(class_div.search('a.sg-header-heading').text)

        last_update = class_div.search('span').select{|s| s[:id][/plnMain_rptAssigmnetsByCourse_lblLastUpdDate_/]}.first.text
        last_update = last_update.gsub(/\(Last Updated: (.*)\)/i, '\1') # Use the first element of the capture group as the replace text.

        average = class_div.search('span').select{|s| s[:id][/plnMain_rptAssigmnetsByCourse_lblHdrAverage_/]}.first.text
        average = average.gsub(/NINE WEEKS AVERAGE (.*)%/i, '\1') # Use the first element of the capture group as the replace text.

        assignments = []
        class_div.search('div.sg-content-grid > table.sg-asp-table').search('tr.sg-asp-table-data-row').collect do |row|
          row_as_array = row.search('td').map{ |n| clean_text(n.text) }
          assignment = {
              due_date: row_as_array[0],
              date_assigned: row_as_array[1],
              assignment_name: row_as_array[2],
              category: row_as_array[3],
              score: row_as_array[4],
              total_points: row_as_array[5]
          }

          assignments.push assignment
        end

        class_data = {
            class_name: class_name,
            last_update: last_update,
            average: average,
            assignments: assignments
        }

        classes.push class_data
      end

      @results = {
          student_name: @student.student_name,
          student_id: @student.student_id,
          classes: classes
      }

      self
    end

    def ascii_report
      raise NilResultsError, 'Results are nil. Be sure to scrape_for_data first.' if @results.nil?

      rows = @results[:classes].map { |c| [c[:class_name], c[:average], c[:last_update]] }
      table = Terminal::Table.new(title: @results[:student_name], headings: ['Class', 'Average', 'Last Update'], rows: rows)
      table.to_s
    end

    private

    def clean_text(text)
      text = text.gsub(/\r\n/, '')
      text.lstrip!
      text = text.gsub(/\s+/, ' ')
      text.gsub(/ \* $/, '')
    end
  end
end
