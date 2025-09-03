# frozen_string_literal: true

class InvoicesController < ApplicationController
  include Paginated
  def index
    Invoice.order(invoice_date: :desc)
    # render json: paginate(scope)

    data = Invoices::TopMorningSalesQuery.call
    render json: data
  end
end
