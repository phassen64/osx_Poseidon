#!/usr/bin/env ruby 
#   !@€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ+¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÄÖÜÑ×ØÞßäæçîðñôö÷üý.$

#   create file
s = "t02_file_example.txt"
fp = File.open(s, "w")
fp.puts "Hit me Baby one more time!"
fp.close

#  read file    
fp = File.open(s, "r")
puts fp.read
fp.close

#  file.inspect     
fp = File.open(s, "r")
puts fp.inspect
fp.close

#   check file
if (File.exist?(s)) 
    puts "File exists: #{s}"
else
    puts "File does not exist: #{s}"
end

