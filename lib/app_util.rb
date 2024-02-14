class AppUtil
    def self.parse_csv(str)
        # remove leading space on each line
        # remove leading and trailing spaces
        # remove redundant spaces, replace > 1 space with a single space
        # make an array of lines
        # each line split by comma (code, name, price)
        str.gsub(/\n\s*/, "\n").strip.split("\n").
        map{|row| row.gsub(/[\s]+/, ' ').split(",").map{|e| e.strip } }
    end
end