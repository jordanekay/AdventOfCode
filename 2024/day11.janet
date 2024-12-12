(use spork)

(defn solve [input part]
	(def format ~{
		:main (split " " :stone)
		:stone (number :d+)})
	(var stones (peg/match format input))
	(var size (length stones))
	(def cache @{})
	
	(defn digits [stone] (->>
		(string stone)
		(peg/match ~{:main (some (number :d))})))
	(defn value [digit-string]
		(def format ~{:main (* (any "0") (number :d+))})
		(def value (peg/match format digit-string))
		(if value value 0))
	(defn split [stone]
		(def digits (digits stone)) (->>
			digits
			(partition (/ (length digits) 2))
			(map |(map string $))
			(map string/join)
			(map value)
			flatten))
	(defn calculate [stone]
		(cond
			(zero? stone) 1
			(even? (length (digits stone))) (split stone)
			(* 2024 stone)))
	
	(for j 0 75 (do
		(for i 0 (length stones)
			(def stone (get stones i))
			(def value (get cache stone))
			(def value (if value value
				(set (cache stone) (calculate stone))))
			(put stones i value))
			(set stones (flatten stones)))
			(pp (length stones)))
	(length stones))
