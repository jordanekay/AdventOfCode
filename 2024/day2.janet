(defn solve [input part]
	(def format ~{
		:main (split "\n" (group :line))
		:line (some (+ (number :d+) :s))})
	(def reports (peg/match format input))
	(def pairs (map |[$ (reverse $)] reports))
	(defn gradual? [curr next]
		(def diff (- curr next))
		(and (> diff 0) (<= diff 3)))
	(defn strictly-safe? [report]
		(every? (map |(gradual?
			(get report $) (get report (dec $)))
			(range 1 (length report)))))
	(defn safe? [part] (fn result [report]
		(match part
			1 (strictly-safe? report)
			2 (do (def indexes (range (length report)))
				(defn dampened [index]
					(map |(get report $) (filter |(not= $ index) indexes)))
				(any? (map strictly-safe? (map dampened indexes)))))))
	(count |(any? (map (safe? part) $)) pairs))
