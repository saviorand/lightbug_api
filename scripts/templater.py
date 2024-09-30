import os
import tomllib
import argparse
from typing import Any

script_dir = os.path.dirname(os.path.abspath(__file__))
repo_dir = os.path.dirname(script_dir)
template_path = os.path.join(repo_dir, 'recipes', 'recipe.tmpl')


def build_dependency_list(dependencies: dict[str, str]) -> str:
    deps: list[str] = []
    for name, version in dependencies.items():
        start = 0
        operator = "=="
        if version[0] in {'<', '>'}:
            if version[1] != "=":
                operator = version[0]
                start = 1
            else:
                operator = version[:2]
                start = 2

        deps.append(f"    - {name} {operator} {version[start:]}")

    return "\n".join(deps)

def main():
    # Configure the parser to receive the mode argument.
    parser = argparse.ArgumentParser(description='Generate a recipe for the project.')
    parser.add_argument('-m', '--mode', default="default",
                        help="The environment to generate the recipe for. Defaults to 'default'")

    # Print all command-line arguments for debugging
    print(f"Command-line arguments: {sys.argv}")

    try:
        args = parser.parse_args()
    except SystemExit:
        # If argparse raises a SystemExit (which it does for parsing errors),
        # catch it and print a more informative error message
        print(f"Error parsing arguments. Usage: {parser.format_usage()}")
        sys.exit(1)

    # Print parsed arguments for debugging
    print(f"Parsed arguments: {args}")

    # Rest of your main function...
    # Load the project configuration and recipe template.
    try:
        with open('mojoproject.toml', 'rb') as f:
            config = tomllib.load(f)
    except FileNotFoundError:
        print("Error: mojoproject.toml not found. Make sure you're running the script from the correct directory.")
        sys.exit(1)

    try:
        with open('src/template.yaml', 'r') as f:
            recipe = f.read()
    except FileNotFoundError:
        print("Error: src/template.yaml not found. Make sure the template file exists.")
        sys.exit(1)

    # ... (rest of your main function)

if __name__ == '__main__':
    main()
