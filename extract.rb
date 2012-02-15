#!/usr/bin/env ruby
#encoding: UTF-8

$:.unshift('lib')
require 'postal_code_range_extractor'
require 'csv'
require 'pp'

if ARGV.length != 1
  puts 'Usage: extract.rb postal_codes.csv'
  puts 'CSV format: comma separator and two columns: postal code, district name'
  exit 1
end

data = CSV.read(ARGV[0])
data.collect! { |row| [row[0]  ? row[0].split(' ').join.to_i : nil, row[1]] }

ranges = Extractor.extract(data)

# Customize
abbr_to_name = {
  'BL' => 'Bratislavský kraj',
  'TA' => 'Trnavský kraj',
  'TC' => 'Trenčiansky kraj',
  'NI' => 'Nitriansky kraj',
  'ZI' => 'Žilinský kraj',
  'BC' => 'Banskobystrický kraj',
  'PV' => 'Prešovský kraj',
  'KI' => 'Košický kraj'
}

abbr_to_name.each { |abbr, name| ranges[name] = ranges.delete(abbr) if ranges[abbr] }

pp ranges

puts "\nIntegrity check:"

data.each do |(code, region)|
  # Find range for given code
  region = abbr_to_name[region] || region
  matched_regions = []
  ranges.each do |region, rngs|
    rngs.each do |range|
      matched_regions << region if range.include?(code)
    end
  end

  unless matched_regions == [region]
    matched_regions.map! { |r| abbr_to_name[r] || r }
    puts "For code #{code}: expected #{region}, but found #{matched_regions.join(', ')}"
  end
end
