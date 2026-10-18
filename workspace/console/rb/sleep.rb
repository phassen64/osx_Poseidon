=begin
    Theme: Sleep
=end

#   show input args
n = ARGV.size
#   puts "ARGV.size:<#{n}>"
if (n != 1)
    puts "DOS> ruby #{__FILE__} iSleepTime"
    exit -1
end

n = ARGV[0].to_i
# puts "sleep :<#{n}>"
sleep n

exit 0

# sleep 1