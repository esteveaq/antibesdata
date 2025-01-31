import os
import re

base_dir = "../posts"
author_pattern = re.compile(r"^(author:)", re.MULTILINE)

def process_qmd(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()

    # Comment out the 'author' line
    new_content = author_pattern.sub(r"# \1", content)

    if content != new_content:  # Only modify if there was a change
        with open(file_path, "w", encoding="utf-8") as file:
            file.write(new_content)
        print(f"Updated: {file_path}")

for root, _, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".qmd"):
            process_qmd(os.path.join(root, file))

print("Processing complete.")



# What's Changed?
# ✅ No need to detect the YAML block separately – just remove author: directly from the entire file.
# ✅ Fewer lines, same functionality – simplifies logic while keeping it efficient.
# ✅ Still only modifies the file if needed – prevents unnecessary writes.


