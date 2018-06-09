# Rails.application.config.content_security_policy do |p|
#   # p.default_src :self, :https
#   # p.font_src    :self, :https, :data
#   # p.img_src     :self, :https, :data
#   # p.object_src  :none
#   #
#   # if Rails.env.development?
#   #   p.script_src :self, :https, :unsafe_eval
#   # else
#   #   p.script_src :self, :https
#   # end
#   # # p.style_src   :self, :https, :unsafe_inline
#   # p.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035', 'http://localhost:5000/api/bets'
#
#   # Specify URI for violation reports
#   # p.report_uri "/csp-violation-report-endpoint"
# end

Rails.application.config.content_security_policy do |policy|
  policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035", 'http://localhost:5000' if Rails.env.development?
  if Rails.env.development?
    policy.script_src :self, :https, :unsafe_eval, :http, :self
  else
    policy.script_src :self, :https
  end
end