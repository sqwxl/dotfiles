function edit_git_diff_files --argument ref
    git diff $ref --name-only | awk -F/ '{ if (NR > 1) {for(i=1;i<=NF;i++) {printf $i; if (i<NF) printf "/"}; printf " " }}' | xargs nvim
end
