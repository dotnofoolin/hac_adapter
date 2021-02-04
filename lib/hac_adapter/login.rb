module HacAdapter
  class Login < Setup
    def login
      page = agent.get("#{@url}/Account/LogOn")

      # Figure out the 'Database' value for @school
      school_database_value = nil
      if match = page.body.match(/<option value="([0-9]+)">#{@school}/)
        school_database_value = match.captures.first
      end

      raise SchoolNotFoundError, "#{@school} not found in select list!" if school_database_value.nil?

      # Fill out the login form and submit it.
      form = page.forms.first # Should only be one form on this page.
      form.field_with(name: 'LogOnDetails.UserName').value = @username
      form.field_with(name: 'LogOnDetails.Password').value = @password
      form.field_with(name: 'Database').value = school_database_value
      @response = form.submit

      raise NotLoggedInError, 'You are not logged in!' unless (@response.link_with(text: 'Logoff') || @response.link_with(text: 'Logout'))

      self
    end
  end
end
