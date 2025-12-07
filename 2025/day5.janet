(defn solve [input part]
  (def [range-input id-input] (string/split "\n\n" input))
  (def range-format
    ~{:main (split "\n" (group :range))
      :range (* (number :d+) "-" (number :d+))})
  (def id-format
    ~{:main (split "\n" (number :d+))})
  (def ranges (peg/match range-format range-input))
  (def ids (peg/match id-format id-input))
  (count (fn [id] (some |(and (>= id ($ 0)) (<= id ($ 1))) ranges)) ids))
