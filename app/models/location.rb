class Location < ApplicationRecord
  extend FriendlyId
  friendly_id :city, use: :slugged

  def self.to_csv
    attributes = %w{id city address}

    CSV.generate(headers: true) do |csv|
      csv << ['Id', 'City', 'Address']

      all.each do |location|
        csv << attributes.map{ |attr| location.send(attr) }
      end
    end
  end

  def self.search(keywords)
      if keywords.present?
        where("city LIKE ? or slug LIKE ?", "%#{keywords}%", "%#{keywords}%").pluck(:city, :address).limit(5)
      else
        all
      end
  end
end
