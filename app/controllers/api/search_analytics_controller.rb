class Api::SearchAnalyticsController < Api::ApiController

  def index
    load_and_render
  end

  # mercilessly remove all the analytics records
  def delete_all
    SearchAnalytic.destroy_all
    load_and_render
  end

  private

  def load_and_render
    @search_analytics = SearchAnalytic.order("quantity DESC").where("quantity > 0").all
    render :index
  end
end
