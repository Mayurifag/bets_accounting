# frozen_string_literal: true

class BaseQuery
  include Pagy::Backend

  def initialize(context)
    @context = context
  end

  private

  def return_result_with_pagy_meta
    {pagy: @pagy, records: @records}
  end

  def set_pagination
    @pagy, @records = pagy(@scope, count: total_records)
  end

  def total_records
    klass.all.size
  end

  def params
    @context
  end
end
