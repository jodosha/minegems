module MetaTagHelper

  # Public: Provides set/get capabilities for managing page identifiers
  # in Rails views and layouts.
  #
  # If called with an argument, appends the argument to the existing page id.
  #
  # args - Zero or more String identifiers that will be concatenated and
  #        separated by spaces.
  #
  # Examples
  #
  #   page_id "page-users"
  #   # => "page-users"
  #   page_id
  #   # => "page-users"
  #   page_id "hidden"
  #   # => "page-users hidden"
  #   page_id
  #   # => "page-users hidden"
  #
  # Returns a String with the current page id.
  def page_id(*args)
    (@_page_id ||= []).concat(args).compact.join(" ")
  end

end
