(defn solve [input part]
  (def format ~{:main (some (+ :product :other))
                :product (/ (* "mul(" :param "," :param ")") ,*)
                :param (number :d+)
                :disable (* "don't()" (thru "do()"))
                :other ,(match part
                          1 1
                          2 '(+ :disable 1))})

  (sum (peg/match format input)))
