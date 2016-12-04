require 'rails_helper'

RSpec.describe Home, type: :model do
  context "with a lob address" do
    before :all do
      #Home.delete_all
      @home = Home.create(
        condo_name: "1000 WEST WASHINGTON LOFTS",
        va_condo_id: "2357",
        detail_uri: "https://vip.vba.va.gov/portal/VBAH/VBAHome/condopu...",
        address: "1000 W WASHINGTON BLVD CHICAGO IL 60607 COOK",
        status: "Accepted Without Conditions",
        last_update: nil,
        request_received_date: "2015-08-01",
        request_completion_date: nil,
      )
      LobAddress.create(
        address_line1: "1000 W WASHINGTON BLVD",
        address_line2: nil,
        address_city: "CHICAGO",
        address_state: "IL",
        address_zip: "60607-2137",
        address_country: "US",
        object: "address",
        message: "Default address: The address you entered was found...",
        home: @home
      )
      @home.reload
    end

    after :all do
      @home.delete
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
          }
        }
      )
    end



  end
end





