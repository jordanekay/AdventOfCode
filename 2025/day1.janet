(defn solve [input part]
  (def format
    ~{:main (split "\n" (group :line))
      :line (* (+ :left :right) (number :d+))
      :right (* "R" (constant 1))
      :left (* "L" (constant -1))})
  (def pairs (peg/match format input))
  (def offsets (array 50 ;(map |(reduce * 1 $) pairs)))
  (def values (accumulate2 + offsets))
  (defn reset? [value] (zero? (mod value 100)))
  (defn intermediates [index]
    (def from (values index))
    (def to (values (inc index)))
    (if (< from to)
      (range (inc from) (inc to))
      (range (dec from) (dec to) -1)))
  (def ranges (map intermediates (range (dec (length values)))))
  (match part
    1 (count reset? values)
    2 (count reset? (flatten ranges))))
