const rl = @import("raylib");

pub fn main() anyerror!void {
    const screenWidth = 1360;
    const screenHeight = 960;

    rl.initWindow(screenWidth, screenHeight, "moon-lander-zig");
    defer rl.closeWindow();

    rl.setWindowPosition(100, 100);
    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        rl.drawText("Hello Raylib World!", 190, 200, 20, rl.Color.light_gray);
    }
}
