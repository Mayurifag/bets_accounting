# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    # The more the threshold, the less results and the stricter the searches
    THRESHOLD_SCORE = 0.3

    def autocomplete_name(query)
      quoted_query = ActiveRecord::Base.connection.quote(query)

      where('similarity(name, :word) > :score', word: quoted_query, score: THRESHOLD_SCORE)
        .order(Arel.sql("similarity(name, #{quoted_query}) DESC"))
    end
  end
end
