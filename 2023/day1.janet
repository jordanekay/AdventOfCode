(defn solve [input part]
	(defn format [part] ~{
		:main (split "\n" (group :line))
		:line (some (choice :digit 1))
		:digit (choice (number :d) :replaced)
		:replaced (if ,['+ (splice (match part 1 [] 2 (do
			(def digits ["one" "two" "three" "four" "five" "six" "seven" "eight" "nine"])
			(def values (range 1 (+ (length digits) 1)))
			(map |~(/ ,$0 ,$1) digits values))))] 1)})
	(def lines (peg/match (format part) input))
	(def calibrate |(+ (* 10 (first $)) (last $)))
	(reduce + 0 (map calibrate lines)))
