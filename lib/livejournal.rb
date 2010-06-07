require 'xml/libxml/xmlrpc'
require 'digest'
require 'net/http'

module LiveJournal
class LiveJournal
  def initialize(params)
    @host = params[:host] || 'livejournal.com'
    @path = params[:path] || '/interface/xmlrpc'
    @username = params[:username]
    @password = params[:password]
    
    @http = Net::HTTP.new(@host)
    @lj = XML::XMLRPC::Client.new(@http, @path)
  end
  
  def get_challenge()
    @lj.call('LJ.XMLRPC.getchallenge').parse!.first[:challenge]
  end
  
  def auth_args
    challenge = get_challenge()
    {:username=>@username, :auth_method=>'challenge', :auth_challenge=>challenge, :auth_response=>Digest::MD5.hexdigest(challenge + Digest::MD5.hexdigest(@password))}
  end 
  
  def login()
    @lj.call('LJ.XMLRPC.login', auth_args).parse!.first
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
    
    @lj.call('LJ.XMLRPC.postevent', args).parse!.first    
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
    
    @lj.call('LJ.XMLRPC.editevent', args).parse!.first    
  end    
  
  def delete_post(itemid,  params={})
    args = auth_args
    args[:ver] = 0
    args[:itemid] = itemid
    args[:subject] = ""
    args[:event] = ""
    args[:usejournal] = params[:username] || @username
    
    @lj.call('LJ.XMLRPC.editevent', args).parse!.first    
  end
end
end