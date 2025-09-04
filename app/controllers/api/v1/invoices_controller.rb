# frozen_string_literal: true

module Api
  module V1
    class InvoicesController < ApplicationController
      include Paginated
      def index
        scope = Invoice.order(invoice_date: :desc)
        result = paginate(scope)
        render json: result, status: :ok
      end

      def mail
        Invoices::TopMorningSalesJob.perform_later
        head :no_content
      end
    end
  end
end
