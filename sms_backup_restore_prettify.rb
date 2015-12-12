#!/usr/bin/env ruby
# encoding: utf-8

require 'nokogiri'

input = ARGV[0]
only_from = ARGV[1] || '.*'

if !input.nil?
  File.open(input) { |f| Nokogiri::XML(f) }.xpath('//sms').each do |sms|
    if sms['address'].gsub(/\D/, '').match(only_from)
      sender = sms['type'] == '2' ? 'Me' : sms['contact_name']
      date = sms['readable_date']
      message = sms['body']

      puts("#{sender} [#{date}]")
      puts("#{message}\n\n")
    end
  end
else
  puts 'usage: ruby sms_backup_restore_prettify.rb input_file.xml (5555551234|5555551235)'
end
