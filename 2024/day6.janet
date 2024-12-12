(defn solve [input part]
	(def format ~{
		:main (split "\n" (group :line))
		:line (some (<- 1))})
	(def rows (peg/match format input))
	(def range (range (length rows)))
	(def indices (map |(find-index |(= "^" $) $) rows))
	(def directions [:up :right :down :left])
	(def row (find-index number? indices))
	(def column (get indices row))
	
	(defn value [row column]
		(get (get rows row) column))
	(defn visit [row column o-row o-column]
		(var visited @{})
		(var direction :up)
		(var spot [row column])
		(defn turn []
			(set direction (get directions (%
				(inc (index-of direction directions))
				(length directions)))))
		(defn next [row column]
			(match direction
				:up [(dec row) column]
				:right [row (inc column)]
				:down [(inc row) column]
				:left [row (dec column)]))
		(while (value ;spot)
			(cond
				(= direction (get visited spot))
					(do (set visited @{}) (set spot [nil nil]))
				(cond
					(= "#" (value ;(next ;spot))) (turn)
					(= (next ;spot) [o-row o-column]) (turn)
					(do (set (visited spot) direction)) (set spot (next ;spot))))) visited)
	(defn obstacle? [o-row o-column]
		(empty? (visit row column o-row o-column)))

	(match part
		1	(length (keys (visit row column nil nil)))
		2 (count true? (flatten (map (fn [row] (map |(obstacle? row $) range)) range)))))

