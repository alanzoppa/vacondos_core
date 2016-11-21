class Home < ApplicationRecord
  has_one :lob_address, dependent: :destroy

  def self.all_complete
    Home.includes(:lob_address).where(
      "EXISTS (SELECT home_id FROM lob_addresses WHERE home_id = homes.id)"
    )
  end
end
