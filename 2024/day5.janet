(defn solve [input part]
	(def format ~{
		:main (split "\n" (group :line))
		:line (+ :rule :update)
		:rule (* (number :d+) "|" (number :d+))
		:update (split "," (number :d+))})
	(def lines (peg/match format input))
	(def rules (filter |(= (length $) 2) lines))
	(def updates (filter |(> (length $) 2) lines))
	(defn applied? [rule update]
		(def pair (map |(index-of $ update) rule))
		(or (some nil? pair) (< (get pair 0) (get pair 1))))
	(defn satisfy [update violation]
		(def indices (map |(index-of (get violation $) update) [0 1])) [
			;(array/slice update 0 (indices 1)) (get violation 0)
			;(array/slice update (indices 1) (indices 0))
			;(array/slice update (inc (indices 0)))])
	(defn adjust [update violations]
		(reduce satisfy update violations))
	(defn correct [update]
		(def violations (filter |(not (applied? $ update)) rules))
		(if (empty? violations) update
			(correct (adjust update violations))))
	(defn middle [update]
		(get update (math/floor (/ (length update) 2))))
	(defn middle-correct [update]
		(if (every? (map |(applied? $ update) rules))
			(middle update) 0))
	(defn middle-incorrect [update]
		(def corrected (correct update))
		(if (= update corrected) 0 (middle corrected)))
	(sum (match part
		1 (map middle-correct updates)
		2 (map middle-incorrect updates))))
	
