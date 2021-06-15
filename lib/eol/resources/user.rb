# frozen_string_literal: true

module Eol
  class User
    include Eol::Resource

    def base_path
      "users/Users"
    end

    def mandatory_attributes
      []
    end

    # https://start.exactonline.nl/docs/HlpRestAPIResourcesDetails.aspx?name=UsersUsers
    def other_attributes
      %i[
        birth_date birth_name created creator creator_full_name customer
        customer_name email end_date first_name full_name gender
        has_registered_for_two_step_verification has_two_step_verification
        initials language last_login last_name middle_name mobile modified
        modifier modifier_full_name nationality notes phone phone_extension
        profile_code start_date start_division title user_name
      ]
    end
  end
end
