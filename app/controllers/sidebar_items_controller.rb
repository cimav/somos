#encoding: utf-8
class SidebarItemsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :json
  def show
    item = SidebarItem.find(params[:id])
    raise "This item is not GET type" if item.sidebar_type != SidebarItem::GET
    url = URI.parse(item.url)
    full_path = (url.query.blank?) ? url.path : "#{url.path}?#{url.query}"
    the_request = Net::HTTP::Get.new(full_path)
    the_response = Net::HTTP.start(url.host, url.port) { |http|
      http.request(the_request)
    }
    raise "Response was not 200, response was #{the_response.code}" if the_response.code != "200"
    render :inline => the_response.body 
  end
end
