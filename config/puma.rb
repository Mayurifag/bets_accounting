# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }.to_i
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
#
port        ENV.fetch('PORT') { 3000 }

# Specifies the `environment` that Puma will run in.
#
rails_env = ENV.fetch('RAILS_ENV') { 'production' }
environment rails_env

app_dir = File.expand_path('..', __dir__)
directory app_dir
shared_dir = "#{app_dir}/tmp"

if %w[production staging].member?(rails_env)
  # Logging
  stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{shared_dir}/pids/puma.pid"
  state_path "#{shared_dir}/pids/puma.state"

  # Change to match your CPU core count
  workers ENV.fetch('WEB_CONCURRENCY') { 1 }

  preload_app!

  # Set up socket location
  bind "unix://#{shared_dir}/sockets/puma.sock"

  before_fork do
    # app does not use database, uncomment when needed
    ActiveRecord::Base.connection_pool.disconnect!
  end

  on_worker_boot do
    require 'active_record'
    require 'erb'
    begin
      ActiveRecord::Base.connection.disconnect!
    rescue StandardError
      ActiveRecord::ConnectionNotEstablished
    end
    ActiveRecord::Base.establish_connection(YAML.load(ERB.new(File.read("#{app_dir}/config/database.yml")).result)[rails_env])
  end
elsif rails_env == 'development'
  # Allow puma to be restarted by `rails restart` command.
  plugin :tmp_restart

  localhost_key = "#{Dir.pwd}/#{File.join('config', 'certs', 'localhost.key')}"
  localhost_cert = "#{Dir.pwd}/#{File.join('config', 'certs', 'localhost.crt')}"

  unless File.exist?(localhost_key)
    def generate_root_cert(root_key)
      root_ca = OpenSSL::X509::Certificate.new
      root_ca.version = 2 # cf. RFC 5280 - to make it a "v3" certificate
      root_ca.serial = 0x0
      root_ca.subject = OpenSSL::X509::Name.parse '/C=BE/O=A1/OU=A/CN=localhost'
      root_ca.issuer = root_ca.subject # root CA's are "self-signed"
      root_ca.public_key = root_key.public_key
      root_ca.not_before = Time.now
      root_ca.not_after = root_ca.not_before + 2 * 365 * 24 * 60 * 60 # 2 years validity
      root_ca.sign(root_key, OpenSSL::Digest::SHA256.new)
      root_ca
    end

    root_key = OpenSSL::PKey::RSA.new(2048)
    file = File.new(localhost_key, 'wb')
    file.write(root_key)
    file.close

    root_cert = generate_root_cert(root_key)
    file = File.new(localhost_cert, 'wb')
    file.write(root_cert)
    file.close
  end

  ssl_bind '0.0.0.0', '8443',
           key: localhost_key,
           cert: localhost_cert

end

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
# preload_app!

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
# on_worker_boot do
#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
# end

# Allow puma to be restarted by `rails restart` command.
# plugin :tmp_restart