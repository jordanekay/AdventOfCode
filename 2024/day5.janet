(defn solve [input part]
  (def format ~{:main (split "\n" (group :line))
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
    (def swapped @[;update])
    (def indices (map |(index-of (get violation $) update) [0 1]))
    (put swapped (get indices 1) (get violation 0))
    (put swapped (get indices 0) (get violation 1)) (pp swapped) swapped)
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
