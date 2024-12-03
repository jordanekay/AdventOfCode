(defn solve [input part]
	(def format ~{
		:main (some (+ :product :other))
		:other ,(match part
			1 1
			2 '(+ :disable 1))
		:product (/ (* "mul(" :param "," :param ")") ,*)
		:param (number :d+)
		:disable (* "don't()" (thru "do()"))})
	(sum (peg/match format input)))
