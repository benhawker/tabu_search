# @author Tomasz Bernaciak <tommybernaciak@gmail.com>
class TabuSearch

  def initialize(graph)
    @graph = graph
    @tabu_list_size = 7
    @max_iteration = 200
  end

  def run
    tabu_list = Array.new( @tabu_list_size )
    current = Graph.clone_graph(@graph)
    best = Graph.clone_graph(current)
    #candidate = Graph.clone( current )
    @max_iteration.times do
      candidate = Graph.clone_graph(current)
      # tabu search
      # choose two random routes
      route1, route2 = candidate.random_routes
      # choose random node from r1
      node1 = route1.random_node
      # find closest node from r2
      node2 = route2.find_closest(node1)
      # relocate n1 from r1 to r2, place it before n2
      route2.add_node(node1, node2)
      route1.delete_node(node1)

      # puts "CHECK:"
      # puts route2.path
      # puts "-----"
      # puts route2.depot
      # puts route2.vertices
      # puts route2.depot
      # puts "______"
      # TUTAJ JEST BŁĄD - ZAMIENIA SIĘ PATH ale VERTICES Zostaje początkowe


      if candidate.cost < current.cost
        current = Graph.clone_graph(candidate)
        best = Graph.clone_graph(candidate) if candidate.cost < best.cost
      # add candidate to tabu list (check size)
      end
    end
    return best
  end

  private

  def is_tabu?(solution, tabu_list)
    tabu_list.each do |forbidden_edge|
      return true if forbidden_edge == solution
    end
    return false
  end

end