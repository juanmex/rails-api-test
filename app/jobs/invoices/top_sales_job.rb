# frozen_string_literal: true

module Invoices
  class TopSalesJob < ApplicationJob
    queue_as :mailers

    def perform
      Rails.logger.info "Invoices::TopMorningSalesJob start: #{Time.zone.now}"
      data = Rails.cache.fetch(['top_sales', Date.current], expires_in: 1.hour) do
        Invoices::TopSalesQuery.call
      end

      TopSalesMailer.top_sales(data).deliver_now
      Rails.logger.info "Invoices::TopMorningSalesJob end: #{Time.zone.now}"
    end
  end
end
