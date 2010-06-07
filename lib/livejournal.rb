require 'xml/libxml/xmlrpc'
require 'digest'
require 'net/http'

module LiveJournal
  class LiveJournalRaw < XML::XMLRPC::Client
    alias inheritedCall call
    
    def call(methodName, *args)
      inheritedCall("LJ.XMLRPC." + methodName.to_s, *args)
    end
  end
  
class LiveJournal
  def initialize(params)
    @host = params[:host] || 'livejournal.com'
    @path = params[:path] || '/interface/xmlrpc'
    @username = params[:username]
    @password = params[:password]
    
    @http = Net::HTTP.new(@host)
    @lj = LiveJournalRaw.new(@http, @path)
  end
  
  def get_challenge()
    @lj.getchallenge().parse!.first[:challenge]
  end
  
  def auth_args
    challenge = get_challenge()
    {:username=>@username, :auth_method=>'challenge', :auth_challenge=>challenge, :auth_response=>Digest::MD5.hexdigest(challenge + Digest::MD5.hexdigest(@password))}
  end 
  
  def login()
    @lj.login(auth_args).parse!.first
  end
  
  def create_post(params)
    args = auth_args
    args[:ver] = 0
    args[:subject] = params[:subject] || "No subject"
    args[:event] = params[:body] || "No body"
    
    args[:security] = params[:security] || 'public'
    args[:allowmask] = params[:allowmask] unless params[:allowmask].blank?
    dt = params[:datetime] || DateTime.now
    args[:year]   = dt.year
    args[:mon]    = dt.month
    args[:day]    = dt.day 
    args[:hour]   = dt.hour
    args[:min]    = dt.min
    args[:usejournal] = params[:username] || @username
    
    @lj.postevent(args).parse!.first    
  end
  
  def update_post(itemid, params)
    args = auth_args
    args[:ver] = 0
    args[:itemid] = itemid
    args[:subject] = params[:subject] || "No subject"
    args[:event] = params[:body] || "No body"
    
    args[:security] = params[:security] || 'public'
    args[:allowmask] = params[:allowmask] unless params[:allowmask].blank?
    dt = params[:datetime] || DateTime.now
    args[:year]   = dt.year
    args[:mon]    = dt.month
    args[:day]    = dt.day 
    args[:hour]   = dt.hour
    args[:min]    = dt.min
    args[:usejournal] = params[:username] || @username
    
    @lj.editeven(args).parse!.first    
  end    
  
  def delete_post(itemid,  params={})
    args = auth_args
    args[:ver] = 0
    args[:itemid] = itemid
    args[:subject] = ""
    args[:event] = ""
    args[:usejournal] = params[:username] || @username
    
    @lj.editevent(args).parse!.first    
  end
end
end