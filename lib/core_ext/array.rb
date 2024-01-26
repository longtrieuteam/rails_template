# frozen_string_literal: true

module CoreExt
  module Array
    # Input:
    # [
    #   { code: 'a', value: 'a' },
    #   { code: 'a', value: 'a1' },
    #   { code: 'b', value: 'b' },
    # ].reduce_resources_by_key(:code)
    #
    # Output:
    # {
    #   'a': { code: 'a', value: 'a1' },
    #   'b': { code: 'b', value: 'b' },
    # }
    #
    def reduce_resources_by_key(key)
      each_with_object({}) do |resource, acc|
        resource = resource.to_mash if resource.is_a?(Hash)

        acc[resource.send(key)] = resource
      end
    end

    # Input:
    # [
    #   { code: 'a', value: 'a' },
    #   { code: 'a', value: 'a1' },
    #   { code: 'b', value: 'b' },
    # ].group_resources_by_key(:code)
    #
    # Output:
    # {
    #   a: [
    #     { number: 'a', value: 'a' },
    #     { number: 'a', value: 'a1' },
    #   ],
    #   b: [
    #     { number: 'b', value: 'b' },
    #   ],
    # }
    #
    def group_resources_by_key(key)
      each_with_object({}) do |resource, acc|
        resource = resource.to_mash if resource.is_a?(Hash)

        acc[resource.send(key)] ||= []
        acc[resource.send(key)] << resource
      end
    end
  end
end

Array.prepend(CoreExt::Array)
