(defn solve [input part]
  (def format
    ~{:main (split "\n" (group :line))
      :line (some (+ (/ "@" 1) (/ "." 0)))})
  (def lines (peg/match format input))
  (def size (length lines))
  (def indexes (range size))
  (defn offset [dx] (map (fn [dy] [dx dy]) [:up :down nil]))
  (def offsets (reduce array/concat @[] (map offset [:left :right nil])))
  (def removable? |(and (>= $ 0) (< $ 4)))
  (defn removable-count [lines]
    (defn paper [x y [dx dy] lines]
      (def x (+ x (match dx :left -1 :right 1 0)))
      (def y (+ y (match dy :up -1 :down 1 0)))
      (def invalid (or (neg? x) (neg? y) (= size x) (= size y) (all nil? [dx dy])))
      (if invalid 0 ((lines x) y)))
    (defn paper-count [x y]
      (if (zero? ((lines x) y)) -1 (sum (map |(paper x y $ lines) offsets))))
    (def counts (map (fn [x] (map (fn [y] (paper-count x y)) indexes)) indexes))
    (defn next-value [x y] (if (removable? ((counts x) y)) 0 ((lines x) y)))
    (def removed-count (count removable? (flatten counts)))
    (def next-lines (map (fn [x] (map (fn [y] (next-value x y)) indexes)) indexes))
    (def finished (or (= part 1) (deep= lines next-lines)))
    (+ removed-count (if finished 0 (removable-count next-lines))))
  (removable-count lines))
