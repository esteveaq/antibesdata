import os
import re

# Define the base directory
base_dir = "../posts"

# Regular expression to match the YAML front matter
yaml_pattern = re.compile(r"^(---\n.*?\n---)", re.DOTALL)
abstract_pattern = re.compile(r"^abstract:\s*(.+)$", re.MULTILINE)

def process_qmd(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()
    
    # Find the YAML front matter
    match = yaml_pattern.search(content)
    if not match:
        return  # No YAML section found
    
    yaml_block = match.group(1)
    
    # Replace 'abstract' with 'subtitle' only in YAML
    new_yaml_block = abstract_pattern.sub(r"subtitle: \1", yaml_block)
    
    if yaml_block != new_yaml_block:  # Only modify if there's a change
        new_content = content.replace(yaml_block, new_yaml_block, 1)
        with open(file_path, "w", encoding="utf-8") as file:
            file.write(new_content)
        print(f"Updated: {file_path}")

# Walk through the directory structure
for root, _, files in os.walk(base_dir):
    if "index.qmd" in files:
        process_qmd(os.path.join(root, "index.qmd"))

print("Processing complete.")
