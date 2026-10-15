import { findMassKill } from "./guard.ts";

const positives = [
	'pkill -f "src/main.ts" -U $(id -u) -n',
	"pkill -f vite",
	"killall Dock",
	"sudo killall -9 node",
	"/usr/bin/pkill node",
	"cd app && pkill -f server; npm start",
	"bash -c 'pkill -f vite'",
	"pgrep -f vite | xargs pkill",
	"pgrep -f vite | xargs kill",
	"pgrep -f vite | xargs kill -9",
	"pgrep -f x | xargs -I{} kill {}",
	"ps aux | grep node | awk '{print $2}' | xargs kill",
	"lsof -ti tcp:4778 | xargs kill",
	"lsof -ti tcp:4778 | xargs kill 2>/dev/null",
	"kill $(pgrep -f vite)",
	"kill -9 `pgrep node`",
	"kill $(lsof -t -i :3000)",
	"kill -9 -1",
	"kill -- -1",
];

const negatives = [
	"kill 1234",
	"kill -9 1234",
	"kill -TERM 1234 5678",
	"kill -1 1234",
	"kill -s TERM 1234",
	"kill $(cat server.pid)",
	'kill "$(cat /tmp/app.pid)"',
	"cat server.pid | xargs kill",
	"lsof -ti tcp:4778 -sTCP:LISTEN | xargs kill",
	"lsof -ti tcp:4778 -s TCP:LISTEN | xargs kill",
	"kill $(lsof -ti tcp:4778 -sTCP:LISTEN)",
	"pgrep -lf node",
	"ps -p 1234 -o pid,command",
	"grep -n pkill notes.md",
	"rg -n 'killall|pkill' src",
	'git commit -m "stop using pkill"',
	'echo "never run kill -9 -1"',
	"docker kill web",
	"tmux kill-session -t scratch",
	"launchctl kickstart -k gui/501/com.example.service",
];

// Known limits, asserted so they stay deliberate.
const knownMisses = [
	"PID=$(pgrep -f vite); kill $PID", // a lookup stored in a variable first
];

let failed = 0;
for (const command of positives) {
	if (!findMassKill(command)) {
		failed++;
		console.log("MISS  ", JSON.stringify(command));
	}
}
for (const command of negatives) {
	if (findMassKill(command)) {
		failed++;
		console.log("FALSE+", JSON.stringify(command), "->", findMassKill(command));
	}
}
for (const command of knownMisses) {
	if (findMassKill(command)) {
		failed++;
		console.log("NOW MATCHES (update knownMisses)", JSON.stringify(command));
	}
}
console.log(failed === 0 ? `ALL OK (${positives.length} positive, ${negatives.length} negative)` : `${failed} FAILURES`);
process.exit(failed === 0 ? 0 : 1);
