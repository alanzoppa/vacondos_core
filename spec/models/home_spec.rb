require 'rails_helper'

condo_hash = {
  condo_name: "1000 WEST WASHINGTON LOFTS",
  va_condo_id: "2357",
  detail_uri: "https://vip.vba.va.gov/portal/VBAH/VBAHome/condopu...",
  address: "1000 W WASHINGTON BLVD CHICAGO IL 60607 COOK",
  status: "Accepted Without Conditions",
  last_update: nil,
  request_received_date: "2015-08-01",
  request_completion_date: nil,
}

lob_address_hash = {
  address_line1: "1000 W WASHINGTON BLVD",
  address_line2: nil,
  address_city: "CHICAGO",
  address_state: "IL",
  address_zip: "60607-2137",
  address_country: "US",
  object: "address",
  message: "Default address: The address you entered was found...",
}

coordinate_hash = {
  latitude:  "1.2345678",
  longitude: "2.8797087",
}


RSpec.describe Home, type: :model do
  context "with a lob address" do
    before :all do
      @home = Home.create(condo_hash)
      LobAddress.create(lob_address_hash.merge(home: @home))
      Coordinate.create(coordinate_hash.merge(home: @home))
      @home.reload
    end

    after :all do
      @home.destroy
    end

    it "should do stuff" do
      expect(@home.confident_to_object).to eql(
        {
          condo_name: "1000 WEST WASHINGTON LOFTS",
          status: "Accepted Without Conditions",
          va_condo_id: "2357",
          address: {
            line1: "1000 W WASHINGTON BLVD",
            line2: nil,
            city: "CHICAGO",
            state: "IL",
            zip: "60607-2137",
            country: "US"
          },
          coordinates: {
            latitude:  "1.2345678",
            longitude: "2.8797087",
          }
        }
      )
    end
  end

  context "without coordinates" do
    before :all do
      @home = Home.create(condo_hash)
      LobAddress.create(lob_address_hash.merge(home: @home))
      @home.reload
    end

    after :all do
      @home.destroy
    end

    #it "should do stuff" do
      #@home.fetch_coordinates!
    #end

    it "should create a search string" do
      expect(@home.google_search_string).to eql "1000 W WASHINGTON BLVD, CHICAGO, IL 60607-2137"
    end


    it "should create an escaped search url" do
      url = @home.google_search_url.to_s
      expect(url).to eql("https://maps.googleapis.com/maps/api/geocode/json?address=1000%2BW%2BWASHINGTON%2BBLVD%252C%2BCHICAGO%252C%2BIL%2B60607-2137&key=AIzaSyDigP87Kd4RoNoCP8yV0g4CCmGp2Ps56Vo")
    end

    it "should return the raw google data as json" do
      data = @home.google_geolocation_response!
      expect(
        data[:results].first[:geometry][:location]
      ).to eql( {"lat"=>41.8834391, "lng"=>-87.65272} )
    end

  end



end





