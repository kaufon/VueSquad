module Pagination
  extend ActiveSupport::Concern
  def items_per_page
    10
  end

  def page_number
    params[:page]&.to_i || 1
  end

  def paginate_offset
    (page_number - 1) * items_per_page
  end

  def paginate
    ->(it) { it.limit(items_per_page).offset(paginate_offset) }
  end
end
