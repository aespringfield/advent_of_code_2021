class PassagePathing
  Cave = Struct.new(:name, :is_big?, :is_terminus?, :connections)

  # TODO: improve performance for part ii
  def self.run(data: File.readlines('./day_12/data.txt', chomp: true), part_ii: false)
    caves = clean(data)
    paths = part_ii ? self.find_paths(caves, single_small_cave_max_visits: 2) : self.find_paths(caves)
    paths.count
  end

  def self.find_paths(caves, path_so_far: ['start'], **opts)
    opts = find_paths_default_opts.merge(opts)
    current_cave_name = path_so_far.last
    caves[current_cave_name].connections.filter_map do |connected_cave_name|
      connected_cave = caves[connected_cave_name]

      if can_visit?(connected_cave, caves, path_so_far, **opts)
        updated_path = [*path_so_far, connected_cave.name]
        connected_cave.name == 'end' ? [updated_path] : find_paths(caves, path_so_far: updated_path, **opts)
      end
    end.flatten(1)
  end

  def self.can_visit?(cave, caves, path_so_far, **opts)
    cave.is_big? ||
      (cave.is_terminus? && !path_so_far.include?(cave.name)) ||
      is_visitable_small_cave?(cave, caves, path_so_far, **opts)
  end

  def self.is_visitable_small_cave?(cave, caves, path_so_far, **opts)
    return false if cave.is_big? || cave.is_terminus?

    # has not hit normal max visits
    path_so_far.count(cave.name) < opts[:normal_small_cave_max_visits] ||
      # no cave has hit single max visits
      path_so_far.tally.max_by { |k, v| caves[k].is_big? ? 0 : v }[1] != opts[:single_small_cave_max_visits]
  end


  def self.clean(data)
    data.each_with_object({}) do |line, memo|
      caves = line.split('-')
      caves.each do |cave|
        memo[cave] ||= Cave.new(
          cave,
          cave == cave.upcase,
          cave == 'start' || cave == 'end',
          []
        )
      end

      cave1, cave2 = caves
      memo[cave1].connections << cave2
      memo[cave2].connections << cave1
    end
  end

  def self.find_paths_default_opts
    {
      normal_small_cave_max_visits: 1,
      single_small_cave_max_visits: 1
    }
  end
end