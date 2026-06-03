# A basic Python program to print "Hello, World!"
print("Hello, World! 🌍")

# This is a comment explaining the code
# The next line prints a greeting message
print("Welcome to Python programming! 🚀")

# --- Tic Tac Toe Game ---
def print_board(board):
    """Prints the current Tic Tac Toe board."""
    size = len(board)
    for i, row in enumerate(board):
        print(" | ".join(row))
        if i < size - 1:
            print("-" * (size * 4 - 3))

def check_winner(board, player):
    """Checks if the given player has won on any row, column, or diagonal for any board size."""
    size = len(board)
    # Check rows and columns
    for i in range(size):
        if all(board[i][j] == player for j in range(size)):
            return True
        if all(board[j][i] == player for j in range(size)):
            return True
    # Check diagonals
    if all(board[i][i] == player for i in range(size)):
        return True
    if all(board[i][size - 1 - i] == player for i in range(size)):
        return True
    return False

def is_draw(board):
    """Checks if the board is full and there is no winner."""
    return all(cell != " " for row in board for cell in row)

def tic_tac_toe():
    """Runs a two-player Tic Tac Toe game in the terminal for any board size."""
    try:
        size = int(input("Enter board size (e.g. 3 for 3x3): "))
        if size < 3:
            print("Board size must be at least 3.")
            return
    except ValueError:
        print("Invalid input. Please enter a number.")
        return
    board = [[" " for _ in range(size)] for _ in range(size)]
    current_player = "X"
    print(f"Tic Tac Toe Game! Player X goes first. Board size: {size}x{size}")
    while True:
        print_board(board)
        try:
            move = input(f"Player {current_player}, enter your move (row and column, e.g. 1 2): ")
            row_str, col_str = move.strip().split()
            row, col = int(row_str) - 1, int(col_str) - 1
            if not (0 <= row < size and 0 <= col < size):
                print(f"Invalid position. Please enter row and column between 1 and {size}.")
                continue
            if board[row][col] != " ":
                print("Cell already taken. Try again.")
                continue
            board[row][col] = current_player
            if check_winner(board, current_player):
                print_board(board)
                print(f"Player {current_player} wins! 🎉")
                break
            if is_draw(board):
                print_board(board)
                print("It's a draw! 🤝")
                break
            current_player = "O" if current_player == "X" else "X"
        except ValueError:
            print("Invalid input. Please enter row and column numbers separated by a space.")

if __name__ == "__main__":
    play = input("Do you want to play Tic Tac Toe? (y/n): ").strip().lower()
    if play == "y":
        tic_tac_toe()

