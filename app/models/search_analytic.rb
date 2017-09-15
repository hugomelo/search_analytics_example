class SearchAnalytic < ApplicationRecord
  after_initialize :set_quantity

  def set_quantity
    self.quantity ||= 0 # 0 if not already set
  end

  # Take advantage of user token being recreated every reload
  # to group queries together. Keeps on Redis the last analytics
  # and update it if user decides to complement the query
  def self.check_new_search token, last_query
    current_query = $redis.get "search:"+token || ""

    # avoid saving analytics while still typing or erasing a query on input
    return if current_query != last_query && (last_query.include?(current_query) || current_query.include?(last_query))

    last_analytic = $redis.get "last_analytic:"+token
    last_analytic = SearchAnalytic.where(id: last_analytic).first if last_analytic.present?

    # if next key is a complement of before, it gives the tracking to the newer key
    if last_analytic && last_query.start_with?(last_analytic.key)
      analytic = SearchAnalytic.find last_analytic.id
      analytic.update quantity: analytic.quantity - 1
    end

    analytic = SearchAnalytic.find_or_initialize_by key: last_query
    analytic.update quantity: analytic.quantity + 1

    $redis.set "last_analytic:"+token, analytic.id

    # remove key
    $redis.del "search:"+token
  end
end
