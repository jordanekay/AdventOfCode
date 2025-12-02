(def day 1)
(def part 1)
(def year 2025)
(defn main [&]
  (eval-string (slurp (string year "/day" day ".janet")))
  (eval-string (string "(print (solve (slurp \"input.txt\")" part "))")))
