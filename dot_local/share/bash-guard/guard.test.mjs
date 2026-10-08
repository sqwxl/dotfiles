import { findBashFileEdit } from "./guard.ts";

const positives = [
	"cat > src/store.rs <<'EOF'\nfn main() {}\nEOF",
	"cat <<'EOF' > src/store.rs\nfn main() {}\nEOF",
	"cat > Makefile <<'EOF'\nall:\nEOF",
	"cat >> src/main.rs <<'EOF'\nfn x() {}\nEOF",
	"echo \"fn main() {}\" > src/main.rs",
	"printf '%s' x > src/out.rs",
	"echo done > status",
	"echo 'export PATH=$PATH:/x' >> .zshrc",
	"printf 'x\\n' >> src/main.rs",
	"cat file | tee other",
	"tee output.txt < input.txt",
	"tee -a /tmp/log.txt < file",
	"truncate -s 0 file.txt",
	"git apply <<'EOF'\ndiff --git a/f b/f\nEOF",
	"patch < fix.diff",
	"sed -i '' 's/a/b/' file.txt",
	"sed -i.bak 's/a/b/' file.txt",
	"sed -e 's/a/b/' -i file.txt",
	"sed --in-place 's/a/b/' file.txt",
	"sed -ni '1p' file.txt",
	"sed 's/a/b/' f > out.txt",
	"perl -pi -e 's/a/b/' file.txt",
	"perl -i -pe 's/a/b/' file.txt",
	"perl -0777 -pi -e 's/a/b/s' f",
	"awk -i inplace '{print}' f",
	"yq -i '.a = 1' f.yaml",
	"/usr/bin/sed -i s/a/b/ f",
	'"sed" -i s/a/b/ f',
	"\\sed -i s/a/b/ f",
	"$'\\x73ed' -i s/a/b/ f",
	"FOO=1 sed -i s/a/b/ f",
	"sudo sed -i 's/a/b/' /etc/hosts",
	"sudo -u root sed -i s/a/b/ f",
	"env FOO=1 sed -i s/a/b/ f",
	"nice -n 5 tee out.txt",
	"timeout 5 sed -i s/a/b/ f",
	"xargs -0 sed -i s/a/b/ f",
	"find . -name '*.rs' | xargs sed -i '' 's/a/b/'",
	"$(sed -i s/a/b/ f)",
	"diff <(tee f) g",
	"cat >| f",
	"cat &> f",
	"cat &>> f",
	"for f in *.rs; do sed -i s/a/b/ $f; done",
	"f() { cat > x; }",
	"cargo build\nsed -i 's/a/b/' f",
	"bash -c \"cat > f <<EOF\nx\nEOF\"",
	'bash -c "cat > f"',
	"bash -c 'echo hi > f.txt'",
	"bash -c 'sed -i s/a/b/ f'",
	"sh -c 'sed -i s/a/b/ f'",
	"bash <<'EOF'\ncat > f\nEOF",
	"eval 'cat > f'",
	"python3 - <<'PY'\nfrom pathlib import Path\nPath('a.txt').write_text('x')\nPY",
	"python3 - <<'PY'\nopen('a.txt','w').write('x')\nPY",
	'python -c "open(\'a.txt\',\'a\').write(\'x\')"',
	"python3 -c \"import pathlib; pathlib.Path('a').write_text('x')\"",
	"python3 -c \"open('a.txt', mode='w').write('x')\"",
	"python3 -c \"print('x', file=open('out.txt','w'))\"",
	"python3 -c \"import shutil; shutil.copy('a','b')\"",
	"python3 -c \"import os; os.remove('x')\"",
	"python3 -c \"with open('f','w') as f: f.write('x')\"",
	"node -e \"require('fs').writeFileSync('a','b')\"",
	"node -e \"require('fs').appendFileSync('a','b')\"",
	"ruby -e \"File.write('a','b')\"",
	"php -r \"file_put_contents('a','b');\"",
	"printf 'open(\"f\",\"w\")' | python3 -",
];

const negatives = [
	"cargo build --release",
	"cargo build > build.log",
	"cargo test 2>&1 | tail -20",
	"sort -k1 data.csv > sorted.csv",
	'rg -n "tee|sed -i" src/',
	"rg -n 'sed -i' src/",
	"grep -n tee file",
	"git log --oneline -20",
	"git log --grep=truncate",
	"npm install",
	"python3 --version",
	'python3 -c "print(1+1)"',
	'python3 -c "import os; print(os.getcwd())"',
	'python3 -c "import json; print(json.dumps({\"a\":1}))"',
	'python3 -c "print(\'cat > file\')"',
	'python3 -c "open(\'f\').read()"',
	"python3 -c \"with open('f', 'r') as f: pass\"",
	"python3 - <<'PY'\nprint(2+2)\nPY",
	"python3 - <<'PY'\nopen('a.txt').read()\nPY",
	'node -e "console.log(process.stdout.write)"',
	'node -e "console.log(1)"',
	"node -e \"require('fs').readFileSync('a','utf8')\"",
	"perl -e 'print 1'",
	"sed -n '1,5p' f",
	"python3 script.py",
	"python3 manage.py migrate",
	"python3 -m venv .venv",
	"python3 -m black src",
	'grep -rn "open(" src',
	"awk '{print $1}' data.csv",
	"echo hello",
	"echo $PATH",
	'echo "a -> b"',
	'echo "a > b"',
	'echo "use cat > file to write"',
	"printf '%s -> %s\\n' a b",
	"printf '%s > %s' a b",
	'git commit -m "use cat > file"',
	"echo 'pipe | sed'",
	'find . -name "*.rs" | xargs wc -l',
	"xargs -I{} cp {} dest",
	"timeout 5 cargo build",
	"nohup make > /tmp/build.log &",
	"cargo fmt",
	"prettier --write src",
	'bash -c "echo hello"',
	"sh -c 'rg \"sed -i\" src'",
	"bash script.sh <<EOF\nsed -i x\nEOF",
	"echo x > /tmp/x",
	"cargo build > /tmp/build.log",
	"git apply --check fix.patch",
	"git apply --stat fix.patch",
	"patch --dry-run < fix.diff",
	"echo code | python3 -",
];

// Known limits, asserted so they stay deliberate.
const knownMisses = [
	"bash -c 'ls > listing.txt'", // redirect producers stay narrow
	"printf 'x' | python3", // no "-" before the pipe
];

let failed = 0;
for (const command of positives) {
	if (!findBashFileEdit(command)) {
		failed++;
		console.log("MISS  ", JSON.stringify(command));
	}
}
for (const command of negatives) {
	if (findBashFileEdit(command)) {
		failed++;
		console.log("FALSE+", JSON.stringify(command), "->", findBashFileEdit(command));
	}
}
for (const command of knownMisses) {
	if (findBashFileEdit(command)) {
		failed++;
		console.log("NOW MATCHES (update knownMisses)", JSON.stringify(command));
	}
}
console.log(failed === 0 ? `ALL OK (${positives.length} positive, ${negatives.length} negative)` : `${failed} FAILURES`);
process.exit(failed === 0 ? 0 : 1);
