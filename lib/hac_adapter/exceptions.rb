module HacAdapter
  class UrlMissingError < StandardError; end
  class SchoolMissingError < StandardError; end
  class UsernameMissingError < StandardError; end
  class PasswordMissingError < StandardError; end
  class SchoolNotFoundError < StandardError; end
  class NotLoggedInError < StandardError; end
  class BadInstanceError < StandardError; end
  class NilResultsError < StandardError; end
end