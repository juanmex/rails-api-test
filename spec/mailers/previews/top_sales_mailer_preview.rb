# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/
class TopSalesMailerPreview < ActionMailer::Preview
  def top_morning_sales
    data = [
      { date: Time.zone.now, total_sales: 4_523_123 },
      { date: Time.zone.now - 1.day, total_sales: 51_231 },
      { date: Time.zone.now - 2.days, total_sales: 123 },
      { date: Time.zone.now - 3.days, total_sales: 13 }
    ]
    TopSalesMailer.top_morning_sales(data)
  end
end
