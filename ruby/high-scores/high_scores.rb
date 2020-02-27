=begin
Write your code for the 'High @scores' exercise in this file. Make the tests in
`high_@scores_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/high-@scores` directory.
=end

class HighScores
    attr_accessor :scores

    def initialize(scores)
        self.scores = scores
    end

    def latest
        self.scores.last
    end

    def personal_best
        self.scores.max
    end

    def personal_top_three
        self.scores.sort.reverse.slice(0, 3)
    end

    def latest_is_personal_best?
        self.scores.last == self.scores.max
    end
end
