const rl = @import("raylib");

pub fn main() anyerror!void {
    const screenWidth = 1360;
    const screenHeight = 960;

    rl.initWindow(screenWidth, screenHeight, "moon-lander-zig");
    defer rl.closeWindow();

    rl.setWindowPosition(100, 100);
    rl.setTargetFPS(60);

    const topLeft = rl.Vector2{ .x = 0, .y = 0 };
    const topRight = rl.Vector2{ .x = screenWidth, .y = 0 };
    const bottomLeft = rl.Vector2{ .x = 0, .y = screenHeight };
    const bottomRight = rl.Vector2{ .x = screenWidth, .y = screenHeight };
    var lineB = rl.Vector2{ .x = screenWidth / 2, .y = screenHeight / 2 };

    while (!rl.windowShouldClose()) {
        // Update game state

        // Render
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.black);

        if (rl.isMouseButtonDown(rl.MouseButton.left)) {
            lineB = rl.getMousePosition();
        }
        rl.drawLineV(topLeft, lineB, rl.Color.white);
        rl.drawLineV(topRight, lineB, rl.Color.white);
        rl.drawLineV(bottomLeft, lineB, rl.Color.white);
        rl.drawLineV(bottomRight, lineB, rl.Color.white);
    }
}
