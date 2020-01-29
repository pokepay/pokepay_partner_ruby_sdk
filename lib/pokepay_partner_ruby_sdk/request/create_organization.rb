module Pokepay::Request
  class CreateOrganization < Request
    def initialize(code, name, issuer_admin_user_email, member_admin_user_email, rest_args = {})
      @path = "/organizations"
      @method = "POST"
      @body_params = { "code" => code,
                       "name" => name,
                       "issuer_admin_user_email" => issuer_admin_user_email,
                       "member_admin_user_email" => member_admin_user_email }.merge(rest_args)
      @response_class = Pokepay::Response::Organization
    end
    attr_reader :response_class
  end
end
