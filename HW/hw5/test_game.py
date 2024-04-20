import unittest
import game
import maze

class TestGame(unittest.TestCase):

    def test1_example_test(self):
        '''An example test that shows all the steps to initialize and invoke the solution algorithm'''

        # Create the maze grid to whatever size you want. But make it 2x2 or greater.
        grid = maze.Maze(5, 5)
        # Use this method to create test mazes
        grid._set_maze([["*", 1,  "*",  1,  1],
                        [2,   5,  "*", "*", 2],
                        [3,  "*", "*", "*", 8],
                        [9,  "*",  4,   7,  3],
                        [1,   3,   1,  "*", 2] ])
        start = (0,1)
        end = (0,3)
        # You need to set the start and end squares this way
        grid.set_start_finish(start, end)
        # Attach the maze to game instance
        testgame = game.Game(grid)
        # Initiate your recursive solution starting at the start square
        score, path = testgame.find_route(start[0], start[1], 0, list())

        # If you need to debug a given test case, it might be helpful to use one or more of these print statements
        print(grid)
        print("path", path)        
        print(grid._print_maze(path))

        # Each test should assert the correct wining score and the correct winning path
        self.assertEqual(score, 49)
        self.assertEqual(path, [(0, 1), (1, 1), (1, 0), (2, 0), (3, 0), (4, 0), (4, 1), (4, 2), (3, 2), (3, 3), (3, 4), (2, 4), (1, 4), (0, 4), (0, 3)])

    #############################################
    # TODO - add the rest of your test cases here

    # tests to see if when the start and finish are next to each other
    def test_nextTo(self): 

        grid = maze.Maze(3,3)

        # creats 3x3 maze
        grid._set_maze([[3,1,1],
                       [5,"*",6],
                       [7,2,8]])
        start = (0,1)
        end = (0,2)

        # makes start and finish right next to each other
        grid.set_start_finish(start,end)

        testgame = game.Game(grid)
        score, path = testgame.find_route(start[0], start[1], 0, list())

        self.assertEqual(score, 31)
        self.assertEqual(path,[(0,1),(0,0),(1,0),(2,0),(2,1),(2,2),(1,2),(0,2)])


    # test rectangular maze to make sure it works the same as a squar maze
    def test_rec(self):
        
        grid = maze.Maze(5,3)

        # creats 3x3 maze
        grid._set_maze([["*", 1,  "*"],
                        [6,   5,  "*"],
                        [3,   9,    1],
                        [4,  "*",   4],
                        [7,   3,    1] ])
        start = (0,1)
        end = (2,2)

        # makes start and finish right next to each other
        grid.set_start_finish(start,end)

        testgame = game.Game(grid)
        score, path = testgame.find_route(start[0], start[1], 0, list())

        self.assertEqual(score, 36)
        self.assertEqual(path,[(0,1), (1,1), (2,1), (2,0), (3,0), (4,0), (4,1), (4,2), (3,2), (2,2)])

    # tests a maze that should not pass
    def test_fail(self):
        grid = maze.Maze(4, 5)
        grid._set_maze([["*", 1,  "*",  1,  1],
                        [6,   5,  "*", "*", "*"],
                        [3,  8, "*", "*", 8],
                        [9,  "*",  1,   4,  3] ])
        start = (0,1)
        end = (0,3)
        grid.set_start_finish(start, end)
        testgame = game.Game(grid)
        score, path = testgame.find_route(start[0], start[1], 0, list())

        self.assertEqual(score, -1)
        self.assertEqual(path, [])

if __name__ == '__main__':
    unittest.main()
    