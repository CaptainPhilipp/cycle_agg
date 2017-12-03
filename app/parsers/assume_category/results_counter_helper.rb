# frozen_string_literal: true

module AssumeCategory
  class ResultsCounterHelper
    class << self
      def sum_results(result_sets)
        count_categories(result_sets.flatten).values
      end

      def cut_by_total_sum(sorted_collection, attribute_name, quantile = 0.5)
        check_quantile!(quantile)
        return sorted_collection if quantile == 1

        sorted_values = sorted_collection.map(&attribute_name)
        reverse_index = quantile_reverse_index(sorted_values, quantile)
        sorted_collection[reverse_index..-1]
      end

      def cut_by_part(sorted_collection, part = 0.5)
        check_quantile!(part)
        return sorted_collection if part == 1
        max_reverse_index = sorted_collection.size
        reverse_index = (max_reverse_index * part).ceil
        sorted_collection[reverse_index..-1]
      end

      def modify_rate(results, modifier)
        results.each { |result| result.rate *= modifier }
      end

      private

      def count_categories(results)
        results_by_category = {}
        results.each do |result|
          sum = (results_by_category[result.category] ||= new_result_object)

          sum.score = sum.score ? sum.score + result.score : result.score
          sum.rate  = sum.rate ? sum.rate + result.rate : result.rate
        end
        results_by_category
      end

      def new_result_object
        CategoriesCounter::Result.new
      end

      def check_quantile!(quantile)
        raise ArgumentError, 'quantile can`t be <= 0' unless quantile.positive?
        raise ArgumentError, 'quantile can`t be > 1' if quantile > 1
      end

      def quantile_reverse_index(sorted_values, quantile)
        limit = sorted_values.reduce(:+) * quantile
        sum   = sorted_values.pop
        sorted_values.reverse_each.with_index do |value, index|
          return -index - 1 if (sum += value) >= limit
        end
      end
    end
  end
end
