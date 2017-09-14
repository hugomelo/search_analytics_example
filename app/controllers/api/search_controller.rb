class Api::SearchController < Api::ApiController

  def index
  end

  def create
    @articles = Article.search params[:q]
    query_key = "search:"+params[:token]
    $redis.set query_key, params[:q]
    SearchAnalyticsWorker.perform_in(10.seconds, query_key, params[:q])
  end
end
