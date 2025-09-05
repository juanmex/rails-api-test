# frozen_string_literal: true

module Api
  module V1
    class InvoicesController < ApplicationController
      include Paginated
      def index
        scope = filtered_scope(Invoice.order(invoice_date: :desc))
        result = paginate(scope)
        render json: result, status: :ok
      end

      def mail
        Invoices::TopSalesJob.perform_later
        render json: { message: 'Job lanzado' }, status: :ok
      end

      def filtered_scope(scope)
        start_date = params[:start_date].presence
        end_date   = params[:end_date].presence

        scope = scope.where('invoice_date >= ?', start_date) if start_date
        scope = scope.where('invoice_date < ?', end_date) if end_date
        scope
      end
    end
  end
end
