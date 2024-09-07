(defn solve [input part]
  (def format ~{
    :main (split "\n" :game)
    :game (/ (* "Game " (number :d+) ": " :rounds) ,|{:id $0 :rounds $&})
    :rounds (split "; " (/ :round ,|(struct (splice (reverse $&)))))
    :round (split ", " :reading)
    :reading (* (number :d+) " " :color)
    :color (/ ':w+ ,keyword)})
  (defn value [{:id id :rounds rounds}]
    (def rgb |[(in $ :red 0) (in $ :green 0) (in $ :blue 0)])
    (def summary (map max (splice (map rgb rounds))))
    (match part 
      1 (do (def limit [12 13 14])
        (if (all < summary limit) id 0))
      2 (product summary)))
  (def games (peg/match format input))
  (reduce + 0 (map value games)))