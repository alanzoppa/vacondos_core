class Home < ApplicationRecord
  has_one :lob_address, dependent: :destroy
  has_one :coordinate, dependent: :destroy

  def confident_to_object
    if self.lob_address.nil? || self.coordinate.nil?
      raise "Do not call this method on an unverified address"
    end
    return {
      condo_name: self.condo_name,
      status: self.status,
      va_condo_id: self.va_condo_id,
      address: {
        line1: self.lob_address.address_line1,
        line2: self.lob_address.address_line2,
        city: self.lob_address.address_city,
        state: self.lob_address.address_state,
        zip: self.lob_address.address_zip,
        country: self.lob_address.address_country,
      },
      coordinates: {
        latitude: self.coordinate.latitude,
        longitude: self.coordinate.longitude
      }

    }
  end

  def fetch_coordinates!
    binding.pry
  end

  def self.all_complete
    Home.includes(:lob_address).where(
      "EXISTS (SELECT home_id FROM lob_addresses WHERE home_id = homes.id)"
    )
  end
end
