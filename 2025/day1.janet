(defn solve [input part]
  (def format
    ~{:main (split "\n" (group :line))
      :line (* (+ (/ "L" -1) (/ "R" 1)) (number :d+))})
  (def pairs (peg/match format input))
  (def offsets (array 50 ;(map |(* ;$) pairs)))
  (def values (accumulate2 + offsets))
  (defn reset? [value] (zero? (mod value 100)))
  (defn intermediates [index]
    (def from (values index))
    (def to (values (inc index)))
    (if (< from to)
      (range (inc from) (inc to))
      (range (dec from) (dec to) -1)))
  (def ranges (map intermediates (range (dec (length values)))))
  (count reset? (match part 1 values 2 (flatten ranges))))
