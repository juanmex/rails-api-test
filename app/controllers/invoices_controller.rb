class InvoicesController < ApplicationController
  include Paginated
  def index
    scope = Invoice.order(invoice_date: :desc)
    render json: paginate(scope)
  end
end
