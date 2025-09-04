# frozen_string_literal: true

module Paginated
  extend ActiveSupport::Concern

  PER_PAGE = 20

  def pagination_params
    page = params.fetch(:page, 1).to_i
    per_page = params.fetch(:per_page, PER_PAGE).to_i
    limit = params.fetch(:per_page, PER_PAGE).to_i
    { page:, items: per_page, limit: }
  end

  def paginate(scope)
    pagy, data = pagy(scope, **pagination_params)
    pagy_meta = pagy_metadata(pagy)
    meta = pagy_meta.slice(:count, :page, :pages)
    meta[:per_page] = pagy_meta[:vars][:items]
    {
      data:,
      meta:
    }
  rescue Pagy::OverflowError => e
    pagy_overflow_response(pages: e.pagy.pages, count: e.pagy.count)
  end

  def pagy_overflow_response(pages:, count:)
    {
      data: [],
      meta: { count:,
              pages:,
              page: pagination_params[:page],
              per_page: pagination_params[:items] }
    }
  end
end
