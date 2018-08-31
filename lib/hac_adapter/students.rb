module HacAdapter
  class Students < Login
    attr_reader :student_name, :student_id

    def initialize(params)
      super(params)
      login
      reset_student_info
    end

    def list_all
      # Returns an array of student ID's

      reset_student_info

      student_id_list = []
      page = agent.get("#{@url}/Frame/StudentPicker")
      form = page.forms.first # Should only be one form on this page.
      form.radiobuttons_with(name: 'studentId').each do |radio|
        student_id_list.push radio.value
      end

      student_id_list
    end

    def select(student_id)
      @student_id = student_id

      # Returns a Students object, with a response attribute set. The @response.body will contain the classes and grades. :)
      page = agent.get("#{@url}/Frame/StudentPicker")
      form = page.forms.first # Should only be one form on this page.
      form.radiobutton_with(value: @student_id).check

      # Put '/HomeAccess/Classes/Classwork' in all hidden 'url' fields. Server will return 500 errors without it.
      form.fields_with(name: 'url').each do |field|
        field.value = "/#{ha_value}/Classes/Classwork"
      end

      @response = form.submit
      @student_name = @response.search('div.sg-banner-chooser > span.sg-banner-text').text

      self
    end

    private

    def reset_student_info
      @student_name = nil
      @student_id = nil
    end

    def ha_value
      @url.split('/').last # Should return HomeAccess or HomeAccess40
    end
  end
end
