import os
import re

# Define the base directory
base_dir = "../posts"

# Regular expression to match the YAML front matter
yaml_pattern = re.compile(r"^(---\n.*?\n---)", re.DOTALL)
abstract_pattern = re.compile(r"(^abstract:\s*(.+))$", re.MULTILINE)

def process_qmd(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()
    
    # Find the YAML front matter
    match = yaml_pattern.search(content)
    if not match:
        return  # No YAML section found
    
    yaml_block = match.group(1)
    
    # Find the abstract line
    abstract_match = abstract_pattern.search(yaml_block)
    if not abstract_match:
        return  # No abstract found
    
    abstract_line = abstract_match.group(1)  # Full line: "abstract: contents..."
    abstract_content = abstract_match.group(2)  # Only the content part
    
    # Create the subtitle line
    subtitle_line = f"subtitle: {abstract_content}"
    
    # Check if subtitle already exists to avoid duplicates
    if f"\n{subtitle_line}" in yaml_block:
        return  # Already processed, skip this file

    # Insert subtitle after abstract
    new_yaml_block = yaml_block.replace(abstract_line, f"{abstract_line}\n{subtitle_line}")

    # Replace the old YAML block with the new one
    new_content = content.replace(yaml_block, new_yaml_block, 1)
    
    # Write changes back to the file
    with open(file_path, "w", encoding="utf-8") as file:
        file.write(new_content)
    
    print(f"Updated: {file_path}")

# Walk through the directory structure
for root, _, files in os.walk(base_dir):
    if "index.qmd" in files:
        process_qmd(os.path.join(root, "index.qmd"))

print("Processing complete.")
