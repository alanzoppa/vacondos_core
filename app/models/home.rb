class Home < ApplicationRecord
  has_one :lob_address, dependent: :destroy
end
