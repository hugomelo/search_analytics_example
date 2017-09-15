class Api::SearchController < Api::ApiController

  def index
  end

  def create
    @articles = Article.search params[:q]

    # keep track of search counts
    $redis.set "search:"+params[:token], params[:q]
    SearchAnalyticsWorker.perform_in(5.seconds, params[:token], params[:q])
  end
end
