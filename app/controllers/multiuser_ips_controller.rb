class MultiuserIpsController < ApplicationController
  def index
    multiuser_ips = MultiuserIp::All.new.call

    render_json_oj({ multiuser_ips: multiuser_ips}, except: [:id])
  end
end
