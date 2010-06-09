require 'test_helper'
require File.join(File.dirname(__FILE__), *%w[.. config lj])

class LiveJournalTest < ActiveSupport::TestCase
  def connection_settings
    {:username=>@@username, :password=>@@password}
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_connection
    assert_not_nil(LiveJournal::Main.new(connection_settings)
  end
  
  def test_login
    @lj = LiveJournal::Main.new(connection_settings)
    assert_not_nil(@lj.login)
  end
  
  def test_post
    @lj = LiveJournal::Main.new(connection_settings)
    assert_not_nil(post = @lj.create_post(:subject=>'livejournal poster test subject', :body=>'Livejournal poster test body'))
    puts "url = " + post[:url]
  end
  
  def test_remove
    @lj = LiveJournal::Main.new(connection_settings)
    post = @lj.create_post(:subject=>'livejournal poster test subject', :body=>'Livejournal poster test body. This post will be removed.')
    puts "url = " + post[:url]
    assert_not_nil(@lj.delete_post(post[:itemid]))
  end
end