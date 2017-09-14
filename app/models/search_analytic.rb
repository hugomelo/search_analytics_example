class SearchAnalytic < ApplicationRecord
  after_initialize :set_quantity

  def set_quantity
    self.quantity ||= 0 # 0 if not already set
  end

  def self.check_new_search query_key, last_query
    current_query = $redis.get query_key
    # avoid saving analytics while still typing or erasing a query on input
    return if current_query != last_query && (last_query.include?(current_query) || current_query.include?(last_query))

    analytic = SearchAnalytic.find_or_initialize_by key: last_query
    analytic.quantity += 1
    analytic.save!
  end
end
