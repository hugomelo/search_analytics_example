class Api::SearchAnalyticsController < Api::ApiController

  def index
    @search_analytics = SearchAnalytic.order("quantity DESC").all
  end
end

