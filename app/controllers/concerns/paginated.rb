module Paginated
  extend ActiveSupport::Concern

  PER_PAGE = 20

  def pagination_params
    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, PER_PAGE).to_i
    { page:, items: per_page }
  end

  def paginate(scope)
     pagy, data = pagy(scope, **pagination_params)
     meta = pagy_metadata(pagy).slice(:count, :page, :pages, :limit)
     meta[:per_page] = meta.delete(:limit)
     {
      data:,
      meta:
     }
  end
end
