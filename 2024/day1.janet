(defn solve [input part]
  (def format ~{:main (split "\n" (group :line))
                :line (some (+ (number :d+) :s))})
  (def pairs (peg/match format input))

  (defn list [side]
    (map |(get $ side) pairs))

  (sum (match part
         1 (map (comp math/abs -) ;(map (comp sorted list) [0 1]))
         2 (map |(* $ (get (frequencies (list 1)) $ 0)) (list 0)))))
