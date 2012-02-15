class Extractor
  class << self
    # Takes data in format: [[123, 'district a'], [233, 'district b']]
    def extract(data)
      raise(ArgumentError, ':data must be Array') unless data.is_a? Array

      # Skips all non-valid data
      filtered_data = data.delete_if { |r| r.compact.length != 2 }

      code_to_district = Hash[filtered_data]
      district_ranges = {}
      last_district = nil

      # Creates ranges to each district
      code_to_district.keys.sort.each do |code|
        district = code_to_district[code]
        range = (district_ranges[district] ||= MultiRange.new)

        district_ranges[last_district].close if last_district and last_district != district
        last_district = district

        range.add(code)
      end

      ret = {}
      # Convert MultiRange instances to Array
      district_ranges.each { |code, range| ret[code] = range.to_a}

      ret
    end
  end
end
