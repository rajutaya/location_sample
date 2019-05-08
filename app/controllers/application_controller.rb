class ApplicationController < ActionController::Base
  require 'params_missing'
  protect_from_forgery with: :exception

   rescue_from ParamsMissing do |exception|
    render json: {status: exception.status, message: exception.info}
  end

  def required_params(params, *arg_list)
    blanks = arg_list - arg_list.reject {|x| params[x] == '' or params[x].nil? }
    raise ParamsMissing.new(info: "blank or missing params: #{blanks.inspect}", status: 412) if blanks.present?
    parameters = arg_list.map {|x| params[x] }
    parameters.count == 1 ? parameters.first : parameters
  end
end
