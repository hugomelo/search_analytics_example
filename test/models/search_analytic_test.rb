require 'test_helper'

class SearchAnalyticTest < ActiveSupport::TestCase

  def setup
    SearchAnalytic.destroy_all
  end

   test "it doesn't add new searches if user is still typing" do
     token = ""
     22.times {token += rand(0..9).to_s }
     query = "How do I c"
     # user changes the query before check
     $redis.set "search:"+token, query + "ancel"
     # check is done with query changed
     SearchAnalytic.check_new_search(token, query)

     assert_equal 0, SearchAnalytic.count
   end

   test "it doesn't add new searches if user is deleting text" do
     token = ""
     22.times {token += rand(0..9).to_s }
     query = "How do I cancel?"

     # user has erased some chars before the job ran
     $redis.set "search:"+token, query[0..-4]

     # the job runs with older whole query
     SearchAnalytic.check_new_search(token, query)

     assert_equal 0, SearchAnalytic.count
   end

   test "it does add new searches if user stopped typing" do
     token = ""
     22.times {token += rand(0..9).to_s }
     query = "How do I c"
     $redis.set "search:"+token, query

     SearchAnalytic.check_new_search(token, query)

     # right the same as before without this line:
     #$redis.set key, query + "ancel"

     # it should count 1
     assert_equal 1, SearchAnalytic.count
   end

   test "it should group searches from the same user until it gets finished" do
     token = ""
     22.times {token += rand(0..9).to_s }

     query = "How do I c"
     $redis.set "search:"+token, query
     SearchAnalytic.check_new_search(token, query)

     query += "ancel my account"
     $redis.set "search:"+token, query
     SearchAnalytic.check_new_search(token, query)

     # it should count only the last
     assert_equal 1, SearchAnalytic.where("quantity > 0").count
     assert_equal query, SearchAnalytic.last.key

   end

end
