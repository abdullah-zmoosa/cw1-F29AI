import hwu_search
class Pathway(hwu_search.State):

    #initializing the coordinates,goal coordinates and cell colours
    def __init__(self, path, x, y, cell_colour):
        self.x, self.y = x, y
        self.goal_coordinates = self.find_goal(path)
        self.cell_colour = cell_colour
        self.children = [] #creating a list to store children states
        self.value = self.calculate_value(x, y, path)

    #creating a method to find the goal coordinates in the maze
    def find_goal(self, path):
        goal_coordinates = [(r, c) for r, row in enumerate(path) for c, cell in enumerate(row) if cell == 'goal']
        return goal_coordinates[0] if goal_coordinates else None
    
    # creating a method to calculate the value of the state given
    def calculate_value(self, x, y, path):
        return x * len(path[0]) + y
    
    #creating a method to check if the state is a goal state
    def isGoal(self):
        return self.cell_colour == 'goal'
    
    #creating a method to get the heuristic value of the state
    def getHeuristic(self):
        return abs(self.y - self.goal_coordinates[1]) + abs(self.x - self.goal_coordinates[0])

class Path_Search(hwu_search.SearchOrder):

    def __init__(self, path):
            self.path = path

    #method to add children states to the fringe with a method path_cost in it
    def addToFringe(self, frontier, parent, children):

        #method to adjust the cell costs, generate rules for the maze and put the states in the frontier
        def path_cost(child_type):
            if child_type == 'white' or child_type == 'goal':
                return 1
            elif child_type == 'grey':
                return 3
            elif child_type == 'black':
                return float('inf')
            else:
                return 0

        x_offsets = [-1, 1, 0, 0]
        y_offsets = [0, 0, -1, 1]

        for x_offset, y_offset in zip(x_offsets, y_offsets):
            child_x, child_y = parent.node.x + x_offset, parent.node.y + y_offset

            if 0 <= child_x < len(self.path) and 0 <= child_y < len(self.path[0]):
                child_type = self.path[child_x][child_y]
                cost = path_cost(child_type)

                if cost != float('inf'):
                    child_state = Pathway(self.path, child_x, child_y, child_type)
                    children.append(hwu_search.ChildWithCost(child_state, cost))

        parent.node.children = children
        print('children generated:', parent.node.children)

        for child_with_cost in children:
            child = child_with_cost.node
            cost = child_with_cost.cost
            f_value = cost + child.getHeuristic()
            frontier.insert(f_value, hwu_search.FringeNode(child, parent, cost))

#creating a method for setting the states for the search operation
def solve_path(path):
    root_state = Pathway(path, 0, 0, path[0][0])
    search_order = Path_Search(path)
    problem = hwu_search.SearchProblem(search_order)
    problem.doSearch(root_state)

if __name__ == '__main__':
    
    # Defining the maze as a 2D array as the outline of the maze in the document
    maze1 = [
        ['root', 'grey', 'white', 'white', 'white', 'white'],
        ['white', 'grey', 'black', 'white', 'grey', 'white'],
        ['white', 'white', 'grey', 'black', 'grey', 'white'],
        ['white', 'white', 'white', 'black', 'goal', 'white'],
    ]

    maze2 = [
        ['root', 'white', 'white', 'white', 'white'],
        ['grey', 'black', 'black', 'black', 'grey'],
        ['white', 'white', 'black', 'white', 'white'],
        ['black', 'white', 'grey', 'white', 'grey'],
        ['white', 'white', 'white', 'white', 'goal'],
    ]
    
    solve_path(maze2)