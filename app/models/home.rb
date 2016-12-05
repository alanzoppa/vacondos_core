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
    l = google_geolocation_response!.dig(:results, 0, :geometry, :location)

    #data[:results].first[:geometry][:location]
    Coordinate.create(
      latitude: l[:lat].to_s,
      longitude: l[:lng].to_s,
      home: self
    )
  end

  def google_search_string
    house = self.lob_address.address_line1
    if self.lob_address.address_line2
      house = "#{house} #{self.lob_address.address_line2}"
    end
    "#{house}, #{self.lob_address.address_city}, #{self.lob_address.address_state} #{self.lob_address.address_zip}"
  end

  def google_search_url
    geo = CONFIG.api_keys.geolocation
    URI::HTTPS.build(
      host: geo[:host],
      path: geo[:path],
      query: {
        key: geo[:key],
        address: CGI.escape(google_search_string)
      }.to_query
    )
  end

  def google_geolocation_response!
    @google_geolocation_response ||= HashWithIndifferentAccess.new.update(
      JSON.parse open(google_search_url).read
    )
    @google_geolocation_response
  end



  #data[:results].first[:geometry][:location]

end
