set :stage, :production # this defines production stage for deployment

set :branch, 'master'

# server '185.58.204.12', roles: %i[web app db], primary: true

server '194.1.236.220', roles: %i[web app db], primary: true