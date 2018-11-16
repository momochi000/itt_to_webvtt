# Copyright Mary Dizon mdizon1@gmail.com
#           Zachery Chin zchin@sproutpost.net
require 'nokogiri'
require 'pry'

class WebVTTConverter
  def initialize(options)
    @config = {
      :infile => options[:infile] || 'sf16thAnv_PreachITT.itt',
      :outfile => options[:outfile] || 'outfile.vtt',
      :fps => options[:fps] || 30
    }
  end

  def convert
    read_file
    output_data = parse_captions

    begin
      File.open(@config[:outfile], 'w') do |file|
        file << "WEBVTT\n\n"
        iter = 1
        output_data.each do |curr_caption|
          file << iter.to_s
          file << "\n"
          file << itt_timestamp_to_vtt_timestamp(curr_caption[:begin_timestamp])
          file << " --> "
          file << itt_timestamp_to_vtt_timestamp(curr_caption[:end_timestamp])
          file << "\n"
          curr_caption[:caption_content].each do |caption_line|
            file << "- #{caption_line}\n"
          end
          file << "\n"
          iter += 1
        end
      end
    rescue => e
      raise "There was a problem opening the file #{@config[:outfile]} for writing #{e}"
    end
  end


  private

  def itt_timestamp_to_vtt_timestamp(timestamp)
    timestamp.sub(/:(\d\d$)/) do |match|
      "." + frame_num_to_milliseconds($1).to_s.rjust(3, '0')
    end
  end

  def frame_num_to_milliseconds(frame_num)
    ((1000/@config[:fps].to_f)*frame_num.to_i).to_i
  end

  def parse_captions
    raise "You must first read the input file before attempting to parse captions" unless @doc
    @doc.css('body div p').map do |p_tag|
      {
        :begin_timestamp => p_tag.attr("begin"),
        :end_timestamp => p_tag.attr("end"),
        :caption_content => p_tag.text.strip.split('  ')
      }
    end
  end

  def read_file
    @doc = File.open(@config[:infile]) { |f| Nokogiri::XML(f) }
  end
end

converter = WebVTTConverter.new({:infile => ARGV[0], :outfile => ARGV[1]})
converter.convert

