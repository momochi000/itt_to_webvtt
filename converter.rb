# Copyright Mary Dizon mdizon1@gmail.com
#           Zachery Chin zchin@sproutpost.net
# TODO: Add MIT license
require 'nokogiri'
require 'pry'

# Read input arguments
# get the input file


input_file = 'sf16thAnv_PreachITT.itt'


doc = File.open(input_file) { |f| Nokogiri::XML(f) }


output = doc.css('body div p').map do |p_tag|

  # do some math to convert timestamp from hh:mm:ss:ff to hh:mm:ss.ttt
  begin_tiemstamp = p_tag.attr("begin")
  end_tiemstamp   = p_tag.attr("end")
  content         = p_tag.text.strip.split('  ')

  [
    begin_tiemstamp,
    end_tiemstamp,
    content
  ]

end

# TODO: 
# open up an output file
# print out boilerplate
# WEBVTT
#
# loop over this output
#   print iterator
#   print begin-timestamp
#   print -->
#   print end-timestamp
#   loop over content string
#     print -
#     print text

#binding.pry

p " PROGRAM END "
