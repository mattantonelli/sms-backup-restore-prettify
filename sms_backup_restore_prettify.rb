#!/usr/bin/env ruby
# encoding: utf-8

require 'nokogiri'

input = ARGV[0]
only_from = ARGV[1] || '.*'

if !input.nil?
  smses = File.open(input) { |f| Nokogiri::XML(f) }.xpath('//sms').each_with_object([]) do |sms, a|
    a << { sender:  sms['type'] == '2' ? 'Me' : sms['contact_name'],
           date:    sms['readable_date'],
           message: sms['body'] } if sms['address'].gsub(/\D/, '').match(only_from)
  end

  File.open('output.txt', 'w') do |output|
    smses.each do |sms|
      output.puts("#{sms[:sender]} [#{sms[:date]}]")
      output.puts("#{sms[:message]}\n\n")
    end
  end
else
  puts 'usage: ruby sms_backup_restore_prettify.rb input_file.xml (5555551234|5555551235)'
end
