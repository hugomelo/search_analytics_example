class Article < ApplicationRecord

  # Search: just a simple way to return results without focusing on article searches.
  def self.search phrase
    sql = phrase.split.map{ |key| "articles.title LIKE '%#{key}%'"}.join(' OR ')
    where(sql)
  end
end
