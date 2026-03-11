import Cocoa

// Find running Ghostty instance
let apps = NSRunningApplication.runningApplications(withBundleIdentifier: "com.mitchellh.ghostty")

guard let ghostty = apps.first else {
    NSWorkspace.shared.open(URL(fileURLWithPath: "/Applications/Ghostty.app"))
    exit(0)
}

let pid = ghostty.processIdentifier
let axApp = AXUIElementCreateApplication(pid)

// Get existing window count
var existingWindows: CFTypeRef?
AXUIElementCopyAttributeValue(axApp, kAXWindowsAttribute as CFString, &existingWindows)
let windowCountBefore = (existingWindows as? [AXUIElement])?.count ?? 0

// Traverse menu bar hierarchy without opening menus visually:
// App → Menu Bar → "File" menu bar item → Menu → "New Window" menu item
var menuBar: CFTypeRef?
guard AXUIElementCopyAttributeValue(axApp, kAXMenuBarAttribute as CFString, &menuBar) == .success else {
    fputs("Failed to get menu bar\n", stderr)
    exit(1)
}

var menuBarItems: CFTypeRef?
guard AXUIElementCopyAttributeValue(menuBar as! AXUIElement, kAXChildrenAttribute as CFString, &menuBarItems) == .success else {
    fputs("Failed to get menu bar items\n", stderr)
    exit(1)
}

var pressed = false
for item in (menuBarItems as! [AXUIElement]) {
    var title: CFTypeRef?
    AXUIElementCopyAttributeValue(item, kAXTitleAttribute as CFString, &title)
    guard let t = title as? String, t == "File" else { continue }

    // Access the submenu directly (no AXPress on File — avoids visual flash)
    var children: CFTypeRef?
    AXUIElementCopyAttributeValue(item, kAXChildrenAttribute as CFString, &children)
    guard let menu = (children as? [AXUIElement])?.first else { break }

    var menuItems: CFTypeRef?
    AXUIElementCopyAttributeValue(menu, kAXChildrenAttribute as CFString, &menuItems)
    guard let items = menuItems as? [AXUIElement] else { break }

    for menuItem in items {
        var menuTitle: CFTypeRef?
        AXUIElementCopyAttributeValue(menuItem, kAXTitleAttribute as CFString, &menuTitle)
        if let mt = menuTitle as? String, mt == "New Window" {
            AXUIElementPerformAction(menuItem, kAXPressAction as CFString)
            pressed = true
            break
        }
    }
    break
}

if !pressed {
    fputs("Failed to find New Window menu item\n", stderr)
    exit(1)
}

// Wait for the new window to appear, then raise only it
usleep(300_000)

var newWindows: CFTypeRef?
AXUIElementCopyAttributeValue(axApp, kAXWindowsAttribute as CFString, &newWindows)

if let wins = newWindows as? [AXUIElement], wins.count > windowCountBefore {
    AXUIElementPerformAction(wins[0], kAXRaiseAction as CFString)
    ghostty.activate()
}
