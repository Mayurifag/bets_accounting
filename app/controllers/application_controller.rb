# TODO: ActionController::API?
class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  protect_from_forgery with: :null_session

  prepend_view_path Rails.root.join('frontend')
end