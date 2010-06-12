require 'test_helper'

class LiveJournalTest < Test::Unit::TestCase
  def connection_settings
    {:username=>@@username, :password=>@@password}
  end
  
  def test_create_update_and_delete
    assert_equal "victor_zagorski", @@username
   
    assert_not_nil(@lj = LiveJournal::Main.new(connection_settings))
    
    assert_not_nil @lj.login, "logging in"
    
    assert_not_nil post = @lj.create_post(:subject=>'livejournal poster test subject', :body=>'Livejournal poster test body', :security=>"private"), "creating post"
    
    puts "url = " + post[:url]
  
    assert_not_nil post = @lj.update_post(post[:itemid], :subject=>'livejournal poster updated test subject', :body=>'Livejournal poster updated test body', :security => "public"), "updating post"

    assert_not_nil @lj.delete_post(post[:itemid]), "deleting post"
  end
end

require File.join(File.dirname(__FILE__), *%w[.. config lj])
