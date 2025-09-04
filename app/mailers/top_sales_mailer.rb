# frozen_string_literal: true

class TopSalesMailer < ApplicationMailer
  default from: ENV.fetch('MAIL_FROM', 'no-reply@example.com')

  def top_sales(data)
    @data = data
    mail(to: ENV['MAIL_TO'], subject: 'Top Morning Sales')
  end
end
