require 'test_helper'

class SearchAnalyticTest < ActiveSupport::TestCase

  def setup
    SearchAnalytic.destroy_all
  end

   test "it doesn't add new searches if user is still typing" do
     key = "search:"
     22.times {key += rand(0..9).to_s }
     query = "How do I c"
     # user changes the query before check
     $redis.set key, query + "ancel"
     # check is done with query changed
     SearchAnalytic.check_new_search(key, query)

     assert_equal 0, SearchAnalytic.count
   end

   test "it doesn't add new searches if user is deleting text" do
     key = "search:"
     22.times {key += rand(0..9).to_s }
     query = "How do I cancel?"

     # user has erased some chars before the job ran
     $redis.set key, query[0..-4]

     # the job runs with older whole query
     SearchAnalytic.check_new_search(key, query)

     assert_equal 0, SearchAnalytic.count
   end

   test "it does add new searches if user stopped typing" do
     key = "search:"
     22.times {key += rand(0..9).to_s }
     query = "How do I c"
     $redis.set key, query

     SearchAnalytic.check_new_search(key, query)

     # right the same as before without this line:
     #$redis.set key, query + "ancel"

     # here it should count
     assert_equal 1, SearchAnalytic.count
   end

end
