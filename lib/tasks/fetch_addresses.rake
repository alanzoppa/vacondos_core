task fetch_addresses: [:environment] do
  Home.joins(:lob_address).each do |home|
    home.coordinates!
  end
end
