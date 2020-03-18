class Map < ApplicationRecord
  belongs_to :product
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  acts_as_mappable(default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude)
end
