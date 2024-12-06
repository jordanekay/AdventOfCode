(use spork)
(defn solve [input part]
	(def format ~{
		:main (split "\n" (group :line))
		:line (some (<- 1))})
	(def target (string/slice "XMAS" (dec part)))
	(def rows (peg/match format input))
	(def columns (math/trans rows))
	(def reversed-rows (math/fliplr rows))
	(def size (length rows))
	(def clamped-range (range (- size (length target) (- 1))))
	(defn diagonal [matrix row column]
		(def value (get (get matrix row) column))
		(if value [value ;(diagonal matrix
			(inc row) (inc column))] []))
	(defn skewed [matrix] [
		;(map |(diagonal matrix 0 $) (range size))
		;(map |(diagonal matrix $ 0) (range 1 size))])
	(def diagonals [;(skewed rows) ;(skewed reversed-rows)])
	(defn count-words [matrix]
		(def lines (map string/join matrix))
		(sum (map |((comp length string/find-all) target $)
			[;lines ;(map string/reverse lines)])))
	(defn valid? [chunk]
		(some |(= $ chunk) [target (string/reverse target)]))
	(defn slice [matrix row column]
		(math/slice-m matrix
			[row (+ row (length target))]
			[column (+ column (length target))]))
	(defn has-pattern? [matrix row column]
		(def area (slice matrix row column))
		(def pairs (map |(diagonal $ 0 0) [area (math/fliplr area)]))
		(all valid? (map string/join pairs)))
	(defn patterns [row]
		(count true? (map |(has-pattern? rows row $) clamped-range)))
	(match part
		1 (sum (map count-words [rows columns diagonals]))
		2 (sum (map patterns clamped-range))))


