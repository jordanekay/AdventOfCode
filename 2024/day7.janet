(use spork)
(defn solve [input part]
	(def format ~{
		:main (split "\n" (group :line))
		:line (* :result ": " :values)
		:result (number :d+)
		:values (some (+ (number :d+) :s))})
	(def lines (peg/match format input))
	(defn permutations [list]
		(distinct (map |[;$] (math/permutations @[;list]))))
	(defn indices [range]
		(def indices @[(map (fn [_] 0) range)])
		(def [left right] (map |(map (fn [_] $) range) [0 1]))
		(each list (map permutations (map |[
			;(array/slice left 0 $)
			;(array/slice right $ -1)] range))
			(array/push indices ;list)) indices)
	(defn test-value [[result values]]
		(defn valid? [operators]
			(def values @[;(reverse values)])
			(each operator operators
				(def value (operator (array/pop values) (last values)))
				(put values (dec (length values)) value))
			(= result (first values)))
		(def placements (map (fn [list]
			(map |(get [+ *] $) list))
				(indices (range (dec (length values))))))
		(match (count valid? placements) 0 0 result))
	(sum (map test-value (pairs (zipcoll
		(map first lines)
		(map |(array/slice $ 1) lines))))))
