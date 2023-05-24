class Patient < ApplicationRecord
    has_one :user, as: :profile
end
