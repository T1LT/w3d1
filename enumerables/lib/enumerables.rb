class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        return self
    end

    def my_select(&prc)
        res = []
        self.my_each do |el|
            res << el if prc.call(el)
        end
        res
    end

    def my_reject(&prc)
        res = []
        self.my_each do |el|
            res << el if !prc.call(el)
        end
        res
    end

    def my_any?(&prc)
        self.my_each do |el|
            return true if prc.call(el)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |el|
            return false if !prc.call(el)
        end
        true
    end

    def my_flatten
        return self if !self.is_a?(Array)
        res = []
        self.my_each do |el|
            if el.is_a?(Array)
                res.push(*el.my_flatten)
            else
                res << el
            end
        end
        res
    end

    def my_zip(*args)
        n = self.length
        res = Array.new(n) { Array.new }
        (0...n).each do |i|
            res[i] << self[i]
        end
        args.each do |arg|
            (0...n).each do |i|
                res[i] << arg[i]
            end
        end
        res
    end

    def my_rotate(amt = 1)
        res = self
        if amt > 0
            amt.times { res.push(res.shift) }
        else
            amt.abs.times { res.unshift(res.pop) }
        end
        res
    end

    def my_join(sep = "")
        res = ""
        (0...self.length).each do |i|
            if i == 0
                res += self[i]
            else
                res += sep + self[i]
            end
        end
        res
    end

    def my_reverse
        res = self
        n = res.length
        (0...n / 2).each do |i|
            res[i], res[n - i - 1] = res[n - i - 1], res[i]
        end
        res
    end
end
