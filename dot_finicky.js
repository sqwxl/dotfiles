// Route link openings by time of day: Chrome during business hours, Firefox
// outside. Finicky is the macOS default browser; it forwards each URL to the
// chosen browser, so the default handler never needs to change.
export default {
  defaultBrowser: () => {
    const now = new Date();
    const hour = now.getHours();
    const day = now.getDay(); // 0 = Sunday .. 6 = Saturday
    const workHours = day >= 1 && day <= 5 && hour >= 9 && hour < 17;

    return workHours ? "com.google.Chrome" : "org.mozilla.firefox";
  },
};
