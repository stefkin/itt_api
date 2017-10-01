class MultiuserIpsController < ApplicationController
  def index
    render json: { multiuser_ips: MultiuserIp::All.new.call }
  end
end
