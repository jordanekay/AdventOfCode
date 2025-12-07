(defn solve [input part]
  (def format
    ~{:main (split "\n" (group :line))
      :line (some (number :d))})
  (def banks (peg/match format input))
  (defn max-joltage [batteries count]
    (if (zero? count) 0
      (do
        (def max-value (max ;(slice batteries 0 (- count))))
        (def index (find-index |(= max-value $) batteries))
        (+ (* max-value (math/pow 10 (dec count)))
           (max-joltage (slice batteries (inc index)) (dec count))))))
  (def count (match part 1 2 2 12))
  (sum (map |(max-joltage $ count) banks)))
