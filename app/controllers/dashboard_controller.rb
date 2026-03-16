class DashboardController < ApplicationController
  def index
    @status_counts = Item.group(:status).count
    @monthly_sales = Item.where(status: "sold")
      .group_by_month(:updated_at)
      .count
  end
end
