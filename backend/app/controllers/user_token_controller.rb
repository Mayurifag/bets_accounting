# frozen_string_literal: true

# Inherited knock_knock gem' class to create action and authentication.
# You may watch it with bundle open knock_knock
#
# POST /auth
# {
#   email: "string@string.string"
#   password: "asdasd"
# }
class UserTokenController < KnockKnock::AuthTokenController; end
