# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    # The more the threshold, the less results and the stricter the searches
    THRESHOLD_SCORE = 0.3

    # TODO: escape this without dangerous query and sql injection
    def autocomplete_name(query)
      where("similarity(name, ?) > #{THRESHOLD_SCORE}", query)
      # .order("similarity(name, #{ActiveRecord::Base.connection.quote(query)}) DESC")
    end
  end
end
