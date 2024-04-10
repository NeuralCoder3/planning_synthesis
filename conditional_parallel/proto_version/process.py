import os

# go through all files with .proto in name
# create file without proto

# replacements = [
#     [
#         ("$PERMUTATION", "perm1"),
#         ("$PERM", "p1")
#     ],
#     [
#         ("$PERMUTATION", "perm2"),
#         ("$PERM", "p2")
#     ]
# ]


replacements = [
    [
        ("$PERMUTATION", f"perm{i}"),
        ("$PERM", f"p{i}")
    ] 
    for i in range(1, 6+1)
]


for file in os.listdir("."):
    if ".proto" in file:
        out_name = file.replace(".proto", "")
        print(f"Processing file: {file} -> {out_name}")
        with open(file, "r") as f:
            content = f.read()
            
        # duplicate lines with replacement strings
        # for each replacement
        lines = content.split("\n")
        new_lines = []
        for line in lines:
            replaced = False
            for repl in replacements:
                new_line = line
                for r in repl:
                    new_line = new_line.replace(r[0], r[1])
                if new_line != line:
                    new_lines.append(new_line)
                    replaced = True
            if not replaced:
                new_lines.append(line)  
        content = "\n".join(new_lines)
            
        with open(out_name, "w") as of:
            of.write(content)
