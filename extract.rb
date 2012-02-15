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
