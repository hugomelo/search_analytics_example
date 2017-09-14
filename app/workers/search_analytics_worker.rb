class SearchAnalyticsWorker
  include Sidekiq::Worker

  def perform(query_key, last_query)
    SearchAnalytic.check_new_search(query_key, last_query)
  end
end
