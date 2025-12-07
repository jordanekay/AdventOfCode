(defn solve [input part]
  (def format
    ~{:main (split "," (group :range))
      :range (* (number :d+) "-" (/ (number :d+) ,inc))})
  (def pairs (peg/match format input))
  (defn repeats? [id size]
    (and
      (> (length id) 1) (int? size)
      (= 1 (length (distinct (partition size id))))))
  (defn check [id]
    (def half-length (/ (length id) 2))
    (def invalid
      (match part
        1 (repeats? id half-length)
        2 (any? (map |(repeats? id $) (range 1 (inc half-length))))))
    (if invalid (scan-number id) 0))
  (defn invalid-count [ids] (+ ;(map check (map string ids))))
  (def ranges (map |(range ;$) pairs))
  (sum (map invalid-count ranges)))
