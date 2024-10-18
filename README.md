# Overview
This repository contains code, covering three important topics: A* search, simple knowledge representation using Prolog, and automated planning in PDDL. The project includes implementations for A* search, a Prolog program for monster-related queries, and PDDL files for automated planning.

## A* Search
- **Code and Grid Output**: The implementation of the A* search algorithm is provided in Python. The output includes the grid representation and the path found by the algorithm.
- **Files**: Includes `maze.py` and `hwu_search.py` to run and test the A* search on a sample grid.

## Knowledge Representation (Prolog)
- **Prolog Program**: The `monster.pl` file contains the Prolog code defining various monsters, their moves, and effectiveness relationships.
- **Example Query Output**: The file `output_prolog.txt` provides examples of different queries executed using the Prolog program, showing interactions between monsters and move effectiveness.

## Automated Planning (PDDL)
- **PDDL Files**: Includes the domain file and multiple problem files to define the automated planning tasks.
- **Report**: A PDF report is provided that explains the planning problems, domain definition, and solutions.

## Repository Structure
1. **A* Search**
   - `maze.py`: Python script representing the maze/grid environment.
   - `hwu_search.py`: Python implementation of the A* search algorithm, used to find the optimal path in the maze.
   - **How to Run**:
     ```
     python hwu_search.py
     ```
2. **Prolog Monster Analysis**
   - `monster.pl`: Prolog code defining monster types, moves, and effectiveness.
   - `output_prolog.txt`: Example output showing results of various queries.
   - **How to Run**:
     ```
     swipl
     [monster].
     ```
3. **Automated Planning (PDDL)**
   - `domain.pddl`: PDDL domain file.
   - `problem1.pddl`, `problem2.pddl`, etc.: PDDL problem files.
   - `report.pdf`: Explains the planning approach, problem definitions, and results.

