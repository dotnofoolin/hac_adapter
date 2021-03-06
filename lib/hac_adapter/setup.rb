module HacAdapter
  class Setup
    attr_reader :response, :agent

    def initialize(params)
      # Hint: the URL needs to look like this: https://hac40.esp.k12.ar.us/HomeAccess40
      @url = params.fetch(:url, nil)
      @school = params.fetch(:school, nil)
      @username = params.fetch(:username, nil)
      @password = params.fetch(:password, nil)

      @response = nil

      raise UrlMissingError, 'URL is missing!' unless @url
      raise SchoolMissingError, 'School is missing!' unless @school
      raise UsernameMissingError, 'Username is missing!' unless @username
      raise PasswordMissingError, 'Password is missing!' unless @password

      @agent = Mechanize.new
      @agent.agent.user_agent = Mechanize::AGENT_ALIASES[(Mechanize::AGENT_ALIASES.keys - ['Mechanize']).sample]
    end
  end
end
